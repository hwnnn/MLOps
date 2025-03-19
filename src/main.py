from fastapi import FastAPI
from pydantic import BaseModel
from typing import Union

app = FastAPI(
    title="FastAPI - Hello World code",
    description="This is the Hello World of FastAPI.",
    version="1.0.0",
)

# Pydantic 모듈의 BaseModel Item 클래스 정의(Request Body로 받을 데이터를 정의)
class Item(BaseModel):
    name: str
    description: Union[str, None] = None
    price: float
    tax: Union[float, None] = None
    
@app.get("/")
def hello_world():
    return "FastAPI World!!"

@app.get("/get_test/{input_val}")
def get_test1(input_val):
    return {"values": input_val}

@app.get("/get_test2/{input_val}")
def get_test2(input_val: int, q: str):
    return {"item_id": input_val, "q": q}

@app.post("/post_test")
def post_test(item: Item):
    return item