import Anthropic from "@anthropic-ai/sdk";

export interface AgentServiceOptions {
  apiKey: string;
}

export class AgentService {
  private client: Anthropic;

  constructor(options: AgentServiceOptions) {
    this.client = new Anthropic({
      apiKey: options.apiKey,
    });
  }

  async generateCompletion(prompt: string, systemPrompt?: string) {
    const response = await this.client.messages.create({
      model: "claude-3-5-sonnet-20241022",
      max_tokens: 1024,
      system: systemPrompt,
      messages: [
        {
          role: "user",
          content: prompt,
        },
      ],
    });

    return {
      text: response.content[0].type === "text" ? response.content[0].text : "",
      usage: response.usage,
      stopReason: response.stop_reason,
    };
  }

  async streamCompletion(prompt: string, systemPrompt?: string) {
    const stream = await this.client.messages.create({
      model: "claude-3-5-sonnet-20241022",
      max_tokens: 1024,
      stream: true,
      system: systemPrompt,
      messages: [
        {
          role: "user",
          content: prompt,
        },
      ],
    });

    return stream;
  }

  async generateWithTools(
    prompt: string,
    tools: Anthropic.Tool[],
    systemPrompt?: string
  ) {
    const response = await this.client.messages.create({
      model: "claude-3-5-sonnet-20241022",
      max_tokens: 4096,
      system: systemPrompt,
      tools,
      messages: [
        {
          role: "user",
          content: prompt,
        },
      ],
    });

    return response;
  }
}
