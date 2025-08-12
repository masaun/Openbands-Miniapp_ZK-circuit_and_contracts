echo "Show the size of the ZK circuit..."
bb gates -b target/openbands_miniapp.json | grep "circuit"

# Logs:
#
# Scheme is: ultra_honk, num threads: 8
#         "circuit_size": 152379
