# AI_AGENT_SimpleCoder

**AI_AGENT_SimpleCoder** is a Python command-line coding agent that uses a **ReAct-style tool loop** to inspect and edit files in a local workspace. It also supports optional task planning and retrieval-augmented generation (RAG) over local Python code.

This repository is for the GitHub account **[@nih00002](https://github.com/nih00002)**. It is a **local development project**, not a hosted or live application.

**Repository:** https://github.com/nih00002/AI_AGENT_SimpleCoder

## Features

- **Coding assistant:** Uses model-generated JSON instructions to read, search, create, and edit files.
- **ReAct loop:** Alternates between reasoning, tool execution, and observations.
- **Task planning:** Optionally breaks a request into smaller steps (`--use-planning`).
- **Code RAG:** Optionally indexes Python code using AST chunks and embeddings (`--use-rag`).
- **Workspace permissions:** Checks access before using file tools; changes normally require approval.
- **API options:** Supports Gemini and configurable OpenAI-compatible endpoints, including a user-configured provider named **WVU API**.

> **WVU API configuration:** The name is a configuration label. This repository does not include, endorse, or verify an official WVU-hosted endpoint. You must provide an authorized API base URL, supported model ID, and your own credentials. No live-demo URL or API key is bundled.

## Requirements

- Python **3.10+**
- Internet access and credentials for the model provider you choose
- Optional: an embedding-capable provider for local-code RAG

## Install

```bash
git clone https://github.com/nih00002/AI_AGENT_SimpleCoder.git
cd AI_AGENT_SimpleCoder
python -m venv .venv
# macOS/Linux:
source .venv/bin/activate
# Windows PowerShell:
# .venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -e .
```

Run from the directory you want the agent to access. **The current working directory becomes its file workspace.** Be careful with sensitive files and external repositories.

## Configure a model provider

### Option 1: WVU API (configurable, OpenAI-compatible)

Only use this option if you have access to an authorized compatible endpoint. Replace the placeholders with the real values **in your terminal**, not in tracked GitHub files:

```bash
export WVU_API_BASE="YOUR_AUTHORIZED_API_BASE_URL"
export WVU_API_KEY="YOUR_PRIVATE_API_KEY"
export SIMPLECODER_MODEL="YOUR_SUPPORTED_MODEL_ID"
```

You can then source the optional helper, which maps those variables to SimpleCoder's provider settings:

```bash
. scripts/simplecoder_init.sh
simplecoder --model "$SIMPLECODER_MODEL" --interactive
```

The interactive CLI also offers **WVU API** in its provider selection menu. It requests the endpoint and key rather than assuming an institutional URL. Do not commit your real credentials.

### Option 2: Gemini

```bash
export GEMINI_API_KEY="YOUR_PRIVATE_GEMINI_KEY"
python -m simplecoder.main --model "gemini/gemini-3-flash-preview" --interactive
```

Choose a model ID supported by your provider; model availability may change.

### Option 3: Other OpenAI-compatible API

```bash
export SIMPLECODER_API_BASE="YOUR_API_BASE_URL"
export SIMPLECODER_API_KEY="YOUR_PRIVATE_API_KEY"
export SIMPLECODER_MODEL="YOUR_SUPPORTED_MODEL_ID"
python -m simplecoder.main --model "$SIMPLECODER_MODEL" --interactive
```

`.env.example` documents the required variables but is **not loaded automatically**. Use shell exports or load a private configuration file yourself. Never commit `.env` or keys.

## Run the agent

Interactive session:

```bash
simplecoder --interactive --verbose
```

One-shot task:

```bash
simplecoder --no-interactive --model "$SIMPLECODER_MODEL" "Explain the functions in main.py"
```

Optional features:

```bash
simplecoder --use-planning "Outline a small REST API"
simplecoder --use-rag "Which function handles tool permissions?"
```

RAG uses the `litellm` embedding API and saves a local index under `.simplecoder/` (ignored by Git). It requires an embedding model and credentials compatible with your provider. If you need to refresh the index, remove that generated cache locally.

### Useful CLI switches

| Switch | Purpose |
|---|---|
| `--model` | Model ID to use |
| `--interactive` / `--no-interactive` | Chat session or one-shot execution |
| `--verbose` | Show progress and tool output |
| `--use-planning` | Generate and follow a task plan |
| `--use-rag` | Retrieve relevant local code chunks |
| `--rag-embedder` | Select embedding model for RAG |
| `--max-iterations` | Limit agent iterations |

## Project structure

```text
AI_AGENT_SimpleCoder/
├── README.md
├── .env.example
├── .gitignore
├── pyproject.toml
├── requirements.txt
├── scripts/
│   └── simplecoder_init.sh
└── simplecoder/
    ├── main.py          # CLI and arguments
    ├── agent.py         # ReAct loop and provider selection
    ├── tools.py         # Workspace file tools
    ├── permissions.py   # Approval rules
    ├── planner.py       # Optional task decomposition
    ├── rag.py           # AST chunks, embeddings, local retrieval
    ├── context.py       # Context tracking and compaction
    └── configs/
        └── permissions.json
```

## Safety and limitations

- **Local development only:** The project has no hosted/live deployment.
- **Review write operations:** An LLM may propose incorrect or destructive edits. Do not enable `SIMPLECODER_AUTO_APPROVE=1` in sensitive workspaces.
- **Workspace boundary:** File tools are intended to operate inside the current working directory; this is not a hardened security sandbox.
- **RAG is optional:** Embedding indexed code may be sent to an external model provider. Avoid indexing confidential code unless permitted.
- **Reproducibility:** LLM output and provider availability can vary. No performance benchmark or production security guarantee is claimed.

## Repository and maintenance

Repository: **[nih00002/AI_AGENT_SimpleCoder](https://github.com/nih00002/AI_AGENT_SimpleCoder)**.

The repository is presented as a personal coding-agent project. It includes no provider credentials, compiled caches, or live service link
