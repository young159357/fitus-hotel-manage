from fastapi import FastAPI, Response

from pydantic import BaseModel

from database_utils import Database

app = FastAPI()

data = Database("data.db")


class LoginInfo(BaseModel):
    username: str
    password: str


@app.post("/login", status_code=200)
def login(login_info: LoginInfo, response: Response):
    if data.check_credentials(login_info.username, login_info.password):
        return {
            "user_info": data.get_user_info(login_info.username),
            "permissions": data.get_user_permissions(login_info.username),
        }
    else:
        response.status_code = 401
        return


@app.get("/hotels_info", status_code=200)
def hotels_info():
    return data.get_hotels_info()