//
// Templates UnitTests
// Copyright © 2020 SwiftGen
// MIT Licence
//

import StencilSwiftKit
import TestUtils
import XCTest

final class JsonTests: XCTestCase {
  private enum Contexts {
    static let all = ["empty", "all"]
  }

  // generate variations to test customname generation
  private let inlineVariations: VariationGenerator = { name, context in
    guard name == "all" else { return [(context: context, suffix: "")] }

    return [
      (
        context: context,
        suffix: ""
      ),
      (
        context: try StencilContext.enrich(context: context, parameters: ["enumName=CustomJSON"]),
        suffix: "-customName"
      ),
      (
        context: try StencilContext.enrich(context: context, parameters: ["forceFileNameEnum"]),
        suffix: "-forceFileNameEnum"
      ),
      (
        context: try StencilContext.enrich(context: context, parameters: ["publicAccess"]),
        suffix: "-publicAccess"
      )
    ]
  }

  func testInlineSwift4() {
    test(
      template: "inline-swift4",
      contextNames: Contexts.all,
      directory: .json,
      contextVariations: inlineVariations
    )
  }

  func testInlineSwift5() {
    test(
      template: "inline-swift5",
      contextNames: Contexts.all,
      directory: .json,
      contextVariations: inlineVariations
    )
  }

  // generate variations to test customname generation
  private let runtimeVariations: VariationGenerator = { name, context in
    guard name == "all" else { return [(context: context, suffix: "")] }

    return [
      (
        context: context,
        suffix: ""
      ),
      (
        context: try StencilContext.enrich(context: context, parameters: ["bundle=ResourcesBundle.bundle"]),
        suffix: "-customBundle"
      ),
      (
        context: try StencilContext.enrich(context: context, parameters: ["enumName=CustomJSON"]),
        suffix: "-customname"
      ),
      (
        context: try StencilContext.enrich(context: context, parameters: ["forceFileNameEnum"]),
        suffix: "-forceFileNameEnum"
      ),
      (
        context: try StencilContext.enrich(
          context: context,
          parameters: ["lookupFunction=myJSONFinder(path:)"]
        ),
        suffix: "-lookupFunction"
      ),
      (
        context: try StencilContext.enrich(context: context, parameters: ["preservePath"]),
        suffix: "-preservePath"
      ),
      (
        context: try StencilContext.enrich(context: context, parameters: ["publicAccess"]),
        suffix: "-publicAccess"
      )
    ]
  }

  func testRuntimeSwift4() {
    test(
      template: "runtime-swift4",
      contextNames: Contexts.all,
      directory: .json,
      contextVariations: runtimeVariations
    )
  }

  func testRuntimeSwift5() {
    test(
      template: "runtime-swift5",
      contextNames: Contexts.all,
      directory: .json,
      contextVariations: runtimeVariations
    )
  }
}
