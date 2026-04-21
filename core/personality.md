{
  "preferred_base_images": {
    "python": "python:3.11-slim",
    "node": "node:20-alpine"
  },
  "common_volumes": ["/app/logs", "/app/data"],
  "agent_frameworks": ["LangGraph", "PydanticAI"],
  "default_skill": "dockerized",
  "skill_hierarchy": {
    "agentic-python": ["dockerized"]
  }
}