#!/usr/bin/env sh
# Optional helper for configuring a user-provided WVU-compatible API.
# Source this script after exporting WVU_API_BASE, WVU_API_KEY, and SIMPLECODER_MODEL.
# No endpoint or credentials are embedded in this repository.

if [ -z "${WVU_API_BASE:-}" ] || [ -z "${WVU_API_KEY:-}" ] || [ -z "${SIMPLECODER_MODEL:-}" ]; then
  printf '%s\n' 'Set WVU_API_BASE, WVU_API_KEY, and SIMPLECODER_MODEL before sourcing this script.' >&2
  return 1 2>/dev/null || exit 1
fi

SIMPLECODER_API_BASE="$WVU_API_BASE"
SIMPLECODER_API_KEY="$WVU_API_KEY"
SIMPLECODER_LITELLM_PROVIDER=openai
export WVU_API_BASE WVU_API_KEY SIMPLECODER_MODEL
export SIMPLECODER_API_BASE SIMPLECODER_API_KEY SIMPLECODER_LITELLM_PROVIDER
printf '%s\n' 'AI_AGENT_SimpleCoder: WVU API configuration loaded (credentials hidden).' >&2
