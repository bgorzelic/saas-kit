import { describe, it, expect } from "vitest";
import { seo } from "../seo";

describe("seo utility", () => {
  it("should generate basic SEO tags with title only", () => {
    const result = seo({ title: "Test Page" });

    expect(result).toContainEqual({ title: "Test Page" });
    expect(result).toContainEqual({ name: "og:title", content: "Test Page" });
    expect(result).toContainEqual({ name: "twitter:title", content: "Test Page" });
  });

  it("should generate SEO tags with title and description", () => {
    const result = seo({
      title: "Test Page",
      description: "This is a test page",
    });

    expect(result).toContainEqual({ name: "description", content: "This is a test page" });
    expect(result).toContainEqual({ name: "og:description", content: "This is a test page" });
    expect(result).toContainEqual({ name: "twitter:description", content: "This is a test page" });
  });

  it("should generate SEO tags with keywords", () => {
    const result = seo({
      title: "Test Page",
      keywords: "test, page, seo",
    });

    expect(result).toContainEqual({ name: "keywords", content: "test, page, seo" });
  });

  it("should generate image tags when image is provided", () => {
    const result = seo({
      title: "Test Page",
      image: "https://example.com/image.jpg",
    });

    expect(result).toContainEqual({ name: "twitter:image", content: "https://example.com/image.jpg" });
    expect(result).toContainEqual({ name: "twitter:card", content: "summary_large_image" });
    expect(result).toContainEqual({ name: "og:image", content: "https://example.com/image.jpg" });
  });

  it("should not include image tags when image is not provided", () => {
    const result = seo({ title: "Test Page" });

    const hasImageTag = result.some(tag => tag.name === "twitter:image");
    expect(hasImageTag).toBe(false);
  });

  it("should include twitter creator and site tags", () => {
    const result = seo({ title: "Test Page" });

    expect(result).toContainEqual({ name: "twitter:creator", content: "@tannerlinsley" });
    expect(result).toContainEqual({ name: "twitter:site", content: "@tannerlinsley" });
  });

  it("should set og:type to website", () => {
    const result = seo({ title: "Test Page" });

    expect(result).toContainEqual({ name: "og:type", content: "website" });
  });

  it("should generate complete SEO tags with all parameters", () => {
    const result = seo({
      title: "Complete Test Page",
      description: "A complete test page with all SEO parameters",
      keywords: "complete, test, seo, all",
      image: "https://example.com/complete-image.jpg",
    });

    expect(result.length).toBeGreaterThan(10);
    expect(result).toContainEqual({ title: "Complete Test Page" });
    expect(result).toContainEqual({ name: "description", content: "A complete test page with all SEO parameters" });
    expect(result).toContainEqual({ name: "keywords", content: "complete, test, seo, all" });
    expect(result).toContainEqual({ name: "og:image", content: "https://example.com/complete-image.jpg" });
  });
});
