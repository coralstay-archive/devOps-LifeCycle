def handler(event, context):
    for record in event.get("Records", []):
        print(f"processing message: {record.get('body')}")
    return {"processed": len(event.get("Records", []))}
