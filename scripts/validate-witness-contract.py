#!/usr/bin/env python3
"""Validate Witness template examples and evidence contract (stdlib; optional jsonschema)."""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def validate_step_evidence(steps: list) -> list[str]:
    errors: list[str] = []
    for i, step in enumerate(steps):
        status = step.get("status")
        evidence = step.get("evidence")
        if status in ("pass", "fail"):
            if not isinstance(evidence, str) or len(evidence.strip()) < 1:
                errors.append(f"steps[{i}]: status {status} requires non-empty evidence")
    return errors


def validate_media_paths(doc: dict, manifest: dict | None) -> list[str]:
    errors: list[str] = []
    artifact_ids = set()
    if manifest:
        for a in manifest.get("artifacts") or []:
            artifact_ids.add(a.get("id"))
            path = a.get("path", "")
            if not isinstance(path, str) or not path.startswith(".witness/"):
                errors.append(f"manifest artifact path must start with .witness/: {path}")
    for i, step in enumerate(doc.get("steps") or []):
        for ref in step.get("media") or []:
            if manifest and ref not in artifact_ids:
                errors.append(f"steps[{i}].media references unknown artifact id: {ref}")
    return errors


def validate_result_doc(doc: dict, manifest: dict | None = None) -> list[str]:
    errors = validate_step_evidence(doc.get("steps") or [])
    errors.extend(validate_media_paths(doc, manifest))
    return errors


def validate_failure_doc(doc: dict) -> list[str]:
    errors: list[str] = []
    fd = doc.get("firstDivergence")
    if not isinstance(fd, dict):
        errors.append("firstDivergence must be an object")
        return errors
    if not fd.get("type") or not fd.get("detail"):
        errors.append("firstDivergence requires type and detail")
    if fd.get("type") == "network":
        for key in ("request", "expected", "actual"):
            if key not in fd:
                errors.append(f"firstDivergence.network requires {key}")
    return errors


def try_jsonschema(instance: dict, schema_path: Path) -> list[str] | None:
    try:
        import jsonschema  # type: ignore
    except ImportError:
        return None
    schema = json.loads(schema_path.read_text(encoding="utf-8"))
    validator = jsonschema.Draft202012Validator(schema)
    return [e.message for e in validator.iter_errors(instance)]


def validate_json_server_db(doc: dict) -> list[str]:
    errors: list[str] = []
    for key, value in doc.items():
        if key.startswith("$"):
            continue
        if not isinstance(value, list):
            continue
        for i, row in enumerate(value):
            if not isinstance(row, dict):
                continue
            if "id" in row and not isinstance(row["id"], str):
                errors.append(f"{key}[{i}].id must be string for json-server v1")
    return errors


def main() -> int:
    errors: list[str] = []

    result_path = ROOT / "templates/runs/checkout-pass/result.json"
    failure_path = ROOT / "templates/runs/checkout-fail/failure.json"
    unknown_path = ROOT / "templates/graph/unknown-state.json"
    visual_result_path = ROOT / "templates/runs/checkout-visual/result.json"
    visual_manifest_path = ROOT / "templates/runs/checkout-visual/media-manifest.json"
    visual_failure_path = ROOT / "templates/runs/checkout-visual/failure.json"
    captcha_failure_path = ROOT / "templates/runs/captcha-security/failure.json"
    captcha_blocked_path = ROOT / "templates/runs/captcha-human-blocked/result.json"
    two_actors_path = ROOT / "templates/runs/two-actors/result.json"
    captcha_state_path = (
        ROOT / "templates/runs/captcha-human-blocked/captcha-state.json"
    )

    result_schema = ROOT / "templates/schemas/result.schema.json"
    failure_schema = ROOT / "templates/schemas/failure.schema.json"
    manifest_schema = ROOT / "templates/schemas/media-manifest.schema.json"
    captcha_state_schema = ROOT / "templates/schemas/captcha-state.schema.json"
    har_report_schema = ROOT / "templates/schemas/har-report.schema.json"
    config_schema = ROOT / "templates/schemas/witness.config.schema.json"
    config_path = ROOT / "templates/witness.config.json"
    har_report_path = ROOT / "templates/runs/checkout-fail/har-report.json"

    for p in (
        result_path,
        failure_path,
        har_report_path,
        unknown_path,
        visual_result_path,
        visual_manifest_path,
        visual_failure_path,
        captcha_failure_path,
        captcha_blocked_path,
        two_actors_path,
        captcha_state_path,
        config_path,
    ):
        if not p.is_file():
            errors.append(f"missing template: {p}")

    result_doc = json.loads(result_path.read_text(encoding="utf-8"))
    failure_doc = json.loads(failure_path.read_text(encoding="utf-8"))
    visual_result = json.loads(visual_result_path.read_text(encoding="utf-8"))
    visual_manifest = json.loads(visual_manifest_path.read_text(encoding="utf-8"))
    visual_failure = json.loads(visual_failure_path.read_text(encoding="utf-8"))
    captcha_failure = json.loads(captcha_failure_path.read_text(encoding="utf-8"))
    captcha_blocked = json.loads(captcha_blocked_path.read_text(encoding="utf-8"))
    two_actors = json.loads(two_actors_path.read_text(encoding="utf-8"))
    captcha_state = json.loads(captcha_state_path.read_text(encoding="utf-8"))
    config_doc = json.loads(config_path.read_text(encoding="utf-8"))
    har_report_doc = json.loads(har_report_path.read_text(encoding="utf-8"))
    mock_db_path = ROOT / "templates/mocks/checkout-db.json"
    if not mock_db_path.is_file():
        errors.append(f"missing template: {mock_db_path}")
    else:
        mock_db = json.loads(mock_db_path.read_text(encoding="utf-8"))
        errors.extend(validate_json_server_db(mock_db))

    errors.extend(validate_result_doc(result_doc))
    errors.extend(validate_result_doc(visual_result, visual_manifest))
    errors.extend(validate_failure_doc(failure_doc))
    errors.extend(validate_failure_doc(visual_failure))
    errors.extend(validate_failure_doc(captcha_failure))
    errors.extend(validate_result_doc(captcha_blocked))
    errors.extend(validate_result_doc(two_actors))

    invalid_pass = {
        "runId": "bad",
        "flowId": "checkout",
        "surface": "desktop",
        "steps": [{"intent": "confirm_payment", "status": "pass"}],
    }
    if not validate_result_doc(invalid_pass):
        errors.append("contract check failed: pass without evidence should be rejected")

    for doc, schema in (
        (result_doc, result_schema),
        (failure_doc, failure_schema),
        (visual_result, result_schema),
        (visual_manifest, manifest_schema),
        (visual_failure, failure_schema),
        (captcha_failure, failure_schema),
        (captcha_blocked, result_schema),
        (two_actors, result_schema),
        (captcha_state, captcha_state_schema),
        (config_doc, config_schema),
        (har_report_doc, har_report_schema),
    ):
        schema_errors = try_jsonschema(doc, schema)
        if schema_errors is not None:
            errors.extend(schema_errors)
    bad_schema_errors = try_jsonschema(invalid_pass, result_schema)
    if bad_schema_errors is not None and not bad_schema_errors:
        errors.append("jsonschema should reject pass without evidence")

    if errors:
        for e in errors:
            print(e, file=sys.stderr)
        return 1
    print("validate-witness-contract: ok")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
