import { poseidon2 } from "poseidon-lite"
import { Noir } from "@noir-lang/noir_js"
import { UltraPlonkBackend } from "@aztec/bb.js"
import { promises as fs } from "fs"
import { exec } from "child_process"
import { promisify } from "util"
import path from "path"

const CIRCUIT_PATH = path.resolve(__dirname, "../../circuits/src/main.nr")
const TARGET_PATH = path.resolve(__dirname, "../../circuits/target/circuit.json")

// This function comes from packages/circuits/tests, with the added return value of merkleProofLength


async function replaceDepthInCircuit(newDepth: number) {
    const circuit = await fs.readFile(CIRCUIT_PATH, "utf-8")
    const modified = circuit.replace(/pub global MAX_DEPTH: u32 = \d+;/, `pub global MAX_DEPTH: u32 = ${newDepth};`)
    await fs.writeFile(CIRCUIT_PATH, modified, "utf-8")
}

async function compileWithNargo() {
    await execAsync("nargo compile", {
        cwd: path.resolve(__dirname, "../")
    })
}

async function getCircuit() {
    const compiledJson = await fs.readFile(TARGET_PATH, "utf-8")
    return JSON.parse(compiledJson)
}

// function getCircuitInput(
//     leafIndex: number,
//     group: Group,
//     secret: bigint,
//     hashedScope: number,
//     hashedMessage: number,
//     MAX_DEPTH: number
// ) {
//     const { merkleProofSiblings, merkleProofIndices, merkleProofLength } = generateMerkleProof(
//         group,
//         leafIndex,
//         MAX_DEPTH
//     )

//     // hashPath is the merkle proof padded with zeroes until MAX_DEPTH length
//     // indexIndices indicates the input order for hashing, also padded with zeroes until MAX_DEPTH
//     const hashPath = merkleProofSiblings.map((s: { toString: () => string }) => s.toString() as `0x${string}`)
//     const indexIndices = merkleProofIndices.map((s: { toString: () => string }) => s.toString() as `0x${string}`)

//     const secretInput = secret.toString() as `0x${string}`
//     const merkleProofLengthInput = merkleProofLength.toString() as `0x${string}`
//     const scopeInput = hashedScope.toString() as `0x${string}`
//     const messageInput = hashedMessage.toString() as `0x${string}`

//     return {
//         secret_key: secretInput,
//         index_bits: indexIndices,
//         hash_path: hashPath,
//         merkle_proof_length: merkleProofLengthInput,
//         hashed_scope: scopeInput,
//         hashed_message: messageInput
//     }
// }

async function getCompiledNoirProgram(MAX_DEPTH: number) {
    await replaceDepthInCircuit(MAX_DEPTH)
    await compileWithNargo()
    const program = await getCircuit()

    const noir = new Noir(program)
    return { noir, program }
}

async function verifyForInputs(
    noir: Noir,
    inputs: {
        secret_key: `0x${string}`
        index_bits: `0x${string}`[]
        hash_path: `0x${string}`[]
        merkle_proof_length: `0x${string}`
        hashed_scope: `0x${string}`
        hashed_message: `0x${string}`
    },
    program: any
) {
    const { witness } = await noir.execute(inputs)

    const backend = new UltraPlonkBackend(program.bytecode)
    const proof = await backend.generateProof(witness)

    const verified = await backend.verifyProof(proof)
    return { verified, proof }
}

describe("Test - ZkJwtProofManager contract", () => {
    // const hashedScope = 32
    // const hashedMessage = 43

    it("Should xxx", async () => {
        // const secret = l - 1n
        // const MAX_DEPTH = 10

        // const commitment = poseidon2(mulPointEscalar(Base8, secret))
        // const group = new Group([2n, 3n, commitment])
        // const inputs = getCircuitInput(2, group, secret, hashedScope, hashedMessage, MAX_DEPTH)

        // const { noir, program } = await getCompiledNoirProgram(MAX_DEPTH)
        // const { verified, proof } = await verifyForInputs(noir, inputs, program)
        // const nullifier = poseidon2([hashedScope, secret])

        // expect(verified).toBe(true)
        // expect(BigInt(proof.publicInputs[0])).toEqual(BigInt(hashedScope))
        // expect(BigInt(proof.publicInputs[1])).toEqual(BigInt(hashedMessage))
        // expect(BigInt(proof.publicInputs[2])).toEqual(BigInt(group.root))
        // expect(BigInt(proof.publicInputs[3])).toEqual(nullifier)
    }, 80000)
}