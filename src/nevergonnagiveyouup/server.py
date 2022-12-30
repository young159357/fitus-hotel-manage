from fastapi import FastAPI, Response

from pydantic import BaseModel

from database_utils import Database

app = FastAPI()

data = Database("data.db")


class LoginInfo(BaseModel):
    username: str
    password: str


class UserInfo(BaseModel):
    Name: str
    Phone: str
    Email: str
    Gender: str
    DOB: str
    Address: str


@app.post("/login", status_code=200)
def login(login_info: LoginInfo, response: Response):
    if data.check_credentials(login_info.username, login_info.password):
        user_data = data.get_user_info(login_info.username)
        return {
            "user_info":
            UserInfo(
                **{
                    key: user_data[i]
                    for i, key in enumerate(UserInfo.__fields__.keys())
                }),
            "permissions":
            data.get_user_permissions(login_info.username),
        }
    else:
        response.status_code = 401
        return