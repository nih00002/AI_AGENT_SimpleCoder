from pathlib import Path
import ast
import tomllib

ROOT = Path(__file__).resolve().parents[1]


def test_source_files_parse():
    for path in (ROOT / "simplecoder").rglob("*.py"):
        ast.parse(path.read_text(encoding="utf-8"))


def test_package_metadata():
    with (ROOT / "pyproject.toml").open("rb") as handle:
        project = tomllib.load(handle)["project"]
    assert project["name"] == "ai-agent-simplecoder"


def test_no_institutional_endpoint_is_embedded():
    agent = (ROOT / "simplecoder" / "agent.py").read_text(encoding="utf-8")
    assert "WVU_API_BASE" in agent
    assert "WVU_API_KEY" in agent
    assert "WVU API" in agent
