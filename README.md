# AES
Advanced Encryption Standard (AES) is a specification for the encryption of electronic data established by the U.S National Institute of Standards and Technology (NIST) in 2001.

### Project Description
Design of an RTL block that implements the AES-128 encryption operation which have the following ports:

![image](https://github.com/YoussefAyman11/AES/assets/104683453/486247cd-16a2-40f5-a158-6a3234624621)


# Explanation
### Data And Key Representation
the plaintext is organized in a 4x4 matrix that is called the state matrix, while the key is organized in a 4x4 matrix that is termed the key matrix
Input data and encryption key is in the form 𝑏0 𝑏1,…,𝑏15 (where 𝑏0  is the first input and the MSB), and is organized to be:
![Untitled](https://github.com/YoussefAyman11/AES/assets/104683453/1428b52c-0dc9-45a0-88b8-a5877ebdd86f)

### The Encryption And Decryption Processes
The encryption and decryption processes consist of four different operations which are repeated across each round of the 10 rounds, these operations are Add Round Key, Shift Rows, Substitute Bytes and Mix Columns. In addition to the Key Expansion operation in which the encryprion key is expanded to ten different keys.

![image](https://github.com/YoussefAyman11/AES/assets/104683453/bb591478-ca91-4605-a7ef-ceb9c69a7d26)

### Add Round Key
Add Round Key is done by adding the state matrix and the current round key matrix. This adding operation is done by XORing the values together. The first key value used in the algorithm is just the input key.

![111](https://github.com/YoussefAyman11/AES/assets/104683453/64cd6307-a968-45f8-91f4-e19ee7f5604f)

### Sub Bytes
The state matrix is given a non-linear transformation using Sub Bytes. This is done by substituting each byte in the status matrix with the corresponding byte in the SBox.

![111](https://github.com/YoussefAyman11/AES/assets/104683453/2137274b-60a0-4790-b497-71ac12030983)

### Shift Row
Each row is shifted to the left by a different number of bytes depending on row number.

![111](https://github.com/YoussefAyman11/AES/assets/104683453/d8893cae-7f14-4d20-9310-4b8181951509)

### Mix Columns
This step is basically a matrix multiplication. Each column is multiplied with a specific matrix and thus the position of each byte in the column is changed as a result.

![111](https://github.com/YoussefAyman11/AES/assets/104683453/49a3fdf7-6cab-46d7-ad63-6fa0e44b56fb)

### Key Expansion
KeyExpand operations is done every round to generate a new round key for every round. This operation is done by the applying shift,sub bytes and XORing on the least significant 4 bytes of the key matrix.

![111](https://github.com/YoussefAyman11/AES/assets/104683453/e0a4816c-7d55-4f4e-b840-8c74348adbc1)
![111](https://github.com/YoussefAyman11/AES/assets/104683453/940fd40c-b57b-41b7-95ed-c54ca0626ef1)












