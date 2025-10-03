import { describe, it, expect } from "vitest";
import { cn } from "../utils";

describe("cn utility", () => {
  it("should merge class names correctly", () => {
    const result = cn("text-red-500", "bg-blue-500");
    expect(result).toBe("text-red-500 bg-blue-500");
  });

  it("should handle conditional classes", () => {
    const isActive = true;
    const result = cn("base-class", isActive && "active-class");
    expect(result).toBe("base-class active-class");
  });

  it("should handle false conditional classes", () => {
    const isActive = false;
    const result = cn("base-class", isActive && "active-class");
    expect(result).toBe("base-class");
  });

  it("should merge conflicting Tailwind classes correctly", () => {
    const result = cn("p-4", "p-8");
    expect(result).toBe("p-8");
  });

  it("should handle array of classes", () => {
    const result = cn(["text-sm", "font-bold"]);
    expect(result).toContain("text-sm");
    expect(result).toContain("font-bold");
  });

  it("should handle empty input", () => {
    const result = cn();
    expect(result).toBe("");
  });

  it("should filter out undefined and null values", () => {
    const result = cn("text-sm", undefined, null, "font-bold");
    expect(result).toBe("text-sm font-bold");
  });
});
