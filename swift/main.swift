// main.swift - Llama LLM command-line interface
// Copyright (c) 2026 Piotr Fusik
// SPDX-License-Identifier: MIT

import Foundation

class SwiftLoader: Loader
{
	private var handle: FileHandle!

	override func open(_ path: String)
	{
		guard let h = FileHandle(forReadingAtPath: path) else {
			perror(path)
			exit(1)
		}
		handle = h
	}

	private func read(_ count: Int) -> Data
	{
		let data = handle.readData(ofLength: count)
		if data.count != count {
			perror("Error reading file")
			exit(1)
		}
		return data
	}

	override func readInt() -> Int
	{
		return Int(read(4).withUnsafeBytes { $0.load(as: Int32.self) })
	}

	override func readFloat() -> Float
	{
		return read(4).withUnsafeBytes { $0.load(as: Float.self) }
	}

	override func readWeights(_ a: ArrayRef<Int16>, _ n: Int)
	{
		read(n * 2).withUnsafeBytes { raw in
			a.array.withUnsafeMutableBufferPointer { dest in
				_ = dest.update(from: raw.bindMemory(to: Int16.self))
			}
		}
	}

	override func readString() -> String
	{
		return String(decoding: read(readInt()), as: UTF8.self)
	}

	override func close()
	{
		try? handle.close()
	}
}

let args = ArrayRef<String>(Array(CommandLine.arguments.dropFirst()))
exit(Int32(LlamaCli.run(args, Int(CommandLine.argc) - 1, SwiftLoader())))
