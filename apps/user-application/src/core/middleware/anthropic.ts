import Anthropic from "@anthropic-ai/sdk";
import { createMiddleware } from "@tanstack/react-start";
import { env } from "cloudflare:workers";

export const anthropicMiddleware = createMiddleware({
  type: "function",
}).server(async ({ next }) => {
  const anthropic = new Anthropic({
    apiKey: env.ANTHROPIC_API_KEY,
  });

  return next({
    context: {
      anthropic,
    },
  });
});
