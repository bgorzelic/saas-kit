import { defineConfig } from "vitest/config";
import viteReact from "@vitejs/plugin-react";
import viteTsConfigPaths from "vite-tsconfig-paths";

export default defineConfig({
  plugins: [
    viteTsConfigPaths({
      projects: ["./tsconfig.json"],
    }),
    viteReact(),
  ],
  test: {
    globals: true,
    environment: "jsdom",
    setupFiles: [],
    coverage: {
      provider: "v8",
      reporter: ["text", "json", "html", "lcov"],
      exclude: [
        "node_modules/**",
        "dist/**",
        ".wrangler/**",
        "**/*.config.*",
        "**/routeTree.gen.ts",
        "**/*.d.ts",
        "src/server.ts",
        "src/start.tsx",
        "**/__tests__/**",
        "**/*.test.{ts,tsx}",
        "**/*.spec.{ts,tsx}",
      ],
      thresholds: {
        lines: 0,
        functions: 20,
        branches: 20,
        statements: 0,
      },
    },
  },
});
