#!/usr/bin/env python

from pathlib import Path
from node_pb2_grpc import NodeStub
import node_pb2
import grpc

p = Path("/home/f3r10/.polar/networks/2/volumes/c-lightning/alice/lightningd/regtest")
cert_path = p / "client.pem"
key_path = p / "client-key.pem"
ca_cert_path = p / "ca.pem"

creds = grpc.ssl_channel_credentials(
    root_certificates=ca_cert_path.open("rb").read(),
    private_key=key_path.open("rb").read(),
    certificate_chain=cert_path.open("rb").read()
)

channel = grpc.secure_channel(
        "localhost:11002",
        creds,
        options=(("grpc.ssl_target_name_override", "cln"),)
)
stub = NodeStub(channel)

print(stub.Getinfo(node_pb2.GetinfoRequest()))
