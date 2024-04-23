# Web

## HTTP

### HTTP 协议格式

#### client

    ```text
    GET / HTTP/1.0
    User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5)
    Accept: */*
    ```

#### server

头信息 + 空行(\r\n) + 数据

    ```text
    HTTP/1.0 200 OK
    Content-Type: text/plain
    Content-Length: 137582
    Expires: Thu, 05 Dec 1997 16:00:00 GMT
    Last-Modified: Wed, 5 August 1996 15:55:28 GMT
    Server: Apache 0.84

    <html>
    <body>Hello World</body>
    </html>
    ```

### 请求方式

| 方式    | 描述                       |
| :------ | :------------------------- |
| GET     | 请求数据                   |
| POST    | 发送数据给服务器           |
| HEAD    | 请求标头信息               |
| DELETE  | 删除指定的资源             |
| PUT     | 创建或修改数据             |
| PATCH   | 对资源进行部分修改         |
| OPTIONS | 请求允许通信选项           |
| CONNECT | 与服务器创建双向沟通的通道 |
| TRACE   | 回环测试                   |

### Cookie

## WSGI

WSGI(Web Server Gateway Interface)
