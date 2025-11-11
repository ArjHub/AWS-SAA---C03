from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives import serialization
import aws_encryption_sdk
from aws_encryption_sdk.identifiers import CommitmentPolicy
from aws_encryption_sdk.keyrings.raw import RawRsaKeyring
from aws_encryption_sdk.materials_managers.default import DefaultCryptoMaterialsManager

# === Load RSA public key ===
with open("keys/public.pem", "rb") as f:
    public_key_bytes = f.read()

public_key = serialization.load_pem_public_key(public_key_bytes)

# === Create RSA keyring (wraps/unwraps AES data key) ===
keyring = RawRsaKeyring(
    key_namespace="demo",
    key_name="rsa-key-1",
    public_key=public_key,
    private_key=None  # Encryption only (no private key needed here)
)

# === Create the AWS Encryption SDK client ===
encryption_client = aws_encryption_sdk.EncryptionSDKClient(
    commitment_policy=CommitmentPolicy.FORBID_ENCRYPT_ALLOW_DECRYPT
)

# === Encrypt plaintext ===
plaintext = b"My sensitive message"
ciphertext, header = encryption_client.encrypt(
    source=plaintext,
    encryption_context={'purpose': 'demo'},
    materials_manager=DefaultCryptoMaterialsManager(keyring)
)

# === Save the ciphertext ===
with open("secret.enc", "wb") as f:
    f.write(ciphertext)

print("Encrypted successfully!")
print("Ciphertext length:", len(ciphertext))
