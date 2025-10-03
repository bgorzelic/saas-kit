import { createServerFn } from "@tanstack/react-start";
import { anthropicMiddleware } from "@/core/middleware/anthropic";
import { z } from "zod";

const ChatInputSchema = z.object({
  message: z.string().min(1),
  conversationHistory: z.array(
    z.object({
      role: z.enum(["user", "assistant"]),
      content: z.string(),
    })
  ).optional(),
});

type ChatInput = z.infer<typeof ChatInputSchema>;

const baseFunction = createServerFn().middleware([anthropicMiddleware]);

export const chatWithAgent = baseFunction
  .inputValidator((data: ChatInput) => ChatInputSchema.parse(data))
  .handler(async (ctx) => {
    const { message, conversationHistory = [] } = ctx.data;
    const { anthropic } = ctx.context;

    const response = await anthropic.messages.create({
      model: "claude-3-5-sonnet-20241022",
      max_tokens: 1024,
      messages: [
        ...conversationHistory,
        {
          role: "user",
          content: message,
        },
      ],
    });

    return {
      message: response.content[0].type === "text" ? response.content[0].text : "",
      usage: response.usage,
    };
  });

const StreamChatInputSchema = z.object({
  message: z.string().min(1),
  systemPrompt: z.string().optional(),
});

type StreamChatInput = z.infer<typeof StreamChatInputSchema>;

export const streamChatWithAgent = baseFunction
  .inputValidator((data: StreamChatInput) => StreamChatInputSchema.parse(data))
  .handler(async (ctx) => {
    const { message, systemPrompt } = ctx.data;
    const { anthropic } = ctx.context;

    const stream = await anthropic.messages.create({
      model: "claude-3-5-sonnet-20241022",
      max_tokens: 1024,
      stream: true,
      system: systemPrompt,
      messages: [
        {
          role: "user",
          content: message,
        },
      ],
    });

    return stream;
  });
