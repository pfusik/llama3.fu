// llamafu.ts - Llama LLM command-line interface 
// Copyright (c) 2026 Piotr Fusik
// SPDX-License-Identifier: MIT

import fs from "node:fs";
import { Loader, LlamaCli } from "./llamacli.ts";

class NodeLoader extends Loader
{
	#f!: number

	open(path: string): void
	{
		this.#f = fs.openSync(path, "r");
	}

	#read(a: Uint8Array | Int16Array | Int32Array | Float32Array): void
	{
		if (fs.readSync(this.#f, a) != a.length * a.BYTES_PER_ELEMENT)
			throw new Error();
	}

	readInt(): number
	{
		const a = new Int32Array(1);
		this.#read(a);
		return a[0];
	}

	readFloat(): number
	{
		const a = new Float32Array(1);
		this.#read(a);
		return a[0];
	}

	readWeights(a : Int16Array, n: number): void
	{
		this.#read(a);
	}

	readString(): string
	{
		const b = new Uint8Array(this.readInt());
		this.#read(b);
		return new TextDecoder().decode(b);
	}

	close(): void
	{
		fs.closeSync(this.#f);
	}
}

const args = process.argv.slice(2);
process.exit(LlamaCli.run(args, args.length, new NodeLoader()));
