- pip install grpcio-tools
- ```python
python -m grpc_tools.protoc -I . ./node.proto --python_out=. --grpc_python_out=. --experimental_allow_proto3_optional
```
- the same for primitives.proto
- python getInfo.py
- source https://lnroom.live/2023-10-12-live-0015-get-started-with-cln-grpc-plugin/
