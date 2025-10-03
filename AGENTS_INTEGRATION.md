# AI Agents Integration Guide

This SaaS kit now includes full integration with Anthropic's Claude API for building AI agent features.

## What's Been Added

### 1. Anthropic SDK
- **User Application**: `@anthropic-ai/sdk` added to `apps/user-application`
- **Data Service**: `@anthropic-ai/sdk` added to `apps/data-service`

### 2. Middleware & Server Functions

#### **User Application**
- **Middleware**: `apps/user-application/src/core/middleware/anthropic.ts`
  - Initializes Anthropic client with API key from environment
  - Makes client available to all server functions

- **Agent Functions**: `apps/user-application/src/core/functions/agents.ts`
  - `chatWithAgent()` - Standard chat completion with conversation history
  - `streamChatWithAgent()` - Streaming responses for real-time UX

#### **Data Service**
- **Agent Service**: `apps/data-service/src/services/agent.ts`
  - `generateCompletion()` - Single completion
  - `streamCompletion()` - Streaming completion
  - `generateWithTools()` - Agentic workflows with function calling

### 3. Environment Configuration
- `.env.example` - Root level example
- `apps/user-application/.dev.vars.example` - Local dev config
- `apps/data-service/.dev.vars.example` - Data service config

## Setup Instructions

### 1. Get Your Anthropic API Key
```bash
# Sign up at https://console.anthropic.com
# Create an API key in the dashboard
# Copy the key (starts with sk-ant-...)
```

### 2. Configure Local Development
```bash
# User Application
cd apps/user-application
cp .dev.vars.example .dev.vars
# Edit .dev.vars and add your ANTHROPIC_API_KEY

# Data Service
cd apps/data-service
cp .dev.vars.example .dev.vars
# Edit .dev.vars and add your ANTHROPIC_API_KEY
```

### 3. Configure Production (Cloudflare)
```bash
# Set secrets via Wrangler CLI
wrangler secret put ANTHROPIC_API_KEY --name tanstack-start-app
wrangler secret put ANTHROPIC_API_KEY --name saas-kit-data-service

# Or via Cloudflare Dashboard:
# Workers & Pages > Your Worker > Settings > Variables > Encrypted
```

## Usage Examples

### Example 1: Chat Interface Component

```tsx
import { useMutation } from '@tanstack/react-query';
import { chatWithAgent } from '@/core/functions/agents';
import { useState } from 'react';

export function ChatInterface() {
  const [messages, setMessages] = useState<Array<{ role: 'user' | 'assistant', content: string }>>([]);
  const [input, setInput] = useState('');

  const mutation = useMutation({
    mutationFn: chatWithAgent,
    onSuccess: (data) => {
      setMessages(prev => [...prev, { role: 'assistant', content: data.message }]);
    },
  });

  const handleSend = () => {
    if (!input.trim()) return;

    const newMessages = [...messages, { role: 'user' as const, content: input }];
    setMessages(newMessages);

    mutation.mutate({
      message: input,
      conversationHistory: messages,
    });

    setInput('');
  };

  return (
    <div>
      <div className="messages">
        {messages.map((msg, i) => (
          <div key={i} className={msg.role}>
            {msg.content}
          </div>
        ))}
      </div>
      <input
        value={input}
        onChange={(e) => setInput(e.target.value)}
        onKeyDown={(e) => e.key === 'Enter' && handleSend()}
      />
      <button onClick={handleSend} disabled={mutation.isPending}>
        Send
      </button>
    </div>
  );
}
```

### Example 2: Streaming Responses

```tsx
import { streamChatWithAgent } from '@/core/functions/agents';

export function StreamingChat() {
  const [response, setResponse] = useState('');

  const handleStream = async (message: string) => {
    const stream = await streamChatWithAgent({ message });

    for await (const event of stream) {
      if (event.type === 'content_block_delta' && event.delta.type === 'text_delta') {
        setResponse(prev => prev + event.delta.text);
      }
    }
  };

  return (
    <div>
      <button onClick={() => handleStream('Hello!')}>
        Start Stream
      </button>
      <div>{response}</div>
    </div>
  );
}
```

### Example 3: Data Service Integration

```typescript
import { Hono } from 'hono';
import { AgentService } from './services/agent';

const app = new Hono();

app.post('/api/generate', async (c) => {
  const { prompt } = await c.req.json();

  const agentService = new AgentService({
    apiKey: c.env.ANTHROPIC_API_KEY,
  });

  const result = await agentService.generateCompletion(
    prompt,
    'You are a helpful AI assistant.'
  );

  return c.json(result);
});

export default app;
```

## Models Available

- **claude-3-5-sonnet-20241022** (Default) - Best balance of intelligence and speed
- **claude-3-5-haiku-20241022** - Fastest, most cost-effective
- **claude-3-opus-20240229** - Most capable for complex tasks

Update model in the function files as needed.

## Cost Management

- Set token limits with `max_tokens` parameter
- Use cheaper models (Haiku) for simple tasks
- Implement rate limiting in your application
- Monitor usage via Anthropic Console

## Next Steps

1. **Add authentication** - Ensure only authorized users can access agent features
2. **Implement rate limiting** - Protect your API key and manage costs
3. **Add conversation storage** - Store chat history in your database
4. **Build domain-specific agents** - Customize system prompts for your use case
5. **Add tool use** - Enable agents to call functions and APIs

## Resources

- [Anthropic API Documentation](https://docs.anthropic.com)
- [Claude Prompt Engineering](https://docs.anthropic.com/en/docs/prompt-engineering)
- [Function Calling Guide](https://docs.anthropic.com/en/docs/build-with-claude/tool-use)
