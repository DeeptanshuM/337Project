#!/usr/bin/env python
from BitVector import *

#Homework Number: 04
#Name: Gabriel Chen
#ECN Login: chen1528
#Due Date: 02/09/2017
##Python version 3.5 was used

'''
Encrypted text in hex (no newline):
39843a8a494a214c5975f3d791abf0ea
ce248399437c8300f110f9aac21a37a6
05f954445c798aa6991cdc19ac7fe7e1
1ba8bb166c3abdf906532c8b19e1758b
8ea7998cf7496b287abb0f18974811b5
5580508186add0e8d10b65f8a335f959
032ef80f449f460f3230ad92d95678ee
9aebb17f0f6e3170aa62803dfeb94313
4fa67d681e7766a075bed92544257bbc
0e9847f303bad581f36e81febeec29bf
a9359ebc5f18bf75d7833f813d213dd8
33f071c461b9cb307669168d0e89ac75
f5ab0ced945ac76e59cf4a00623bdba6
8625f3a690c9ce8d4a795a3ef781123e
3f137aa226d4a14ebf96f1dbed533fb3
3563daaa69534a3e6fb76bd146426740
68154b2922154c57b6a27bdb760b3590
c52c3c84c719c6ee6b17b9b6657faf91
c24d9d57913d1638edc169e2016e2b56
acf0e2456c42b1575930ee876dd38710
96763ed588d95d0132f9d78c5c676c32
4ab32757155a51518e6784c23b9f7f96
952952f26da2ccda62bc17825704860d
29dc48b8f1f18e5fcecaaf5d44d0f701
66994edeeb5137abb8fc288573afa869
009ffe5ca56ade996e9c37b1770f683b
7d496b67a365e724931092dac38a6469
5ff431f8e442eacc426ac6ed1e4471ec
82ea681f7c634469a2848738bfda7442
af571fa4dac0172ac447a6e6b0f9d164
2b57b7bbaee96f69301c8db64eb053ac
07364137dbcfac2e315b41122e87faf0
fb8ed694ef42898a0051f48f8b4253a4
cbbadc05404f80836176b38970165fa0
343f65cd0a10d98013a5acaebc9bfa41
ddc36b0ee8d9c3dd3c736c7047f4dcc5
27b4ec57152598a5890181246e218fb7
2a844d6ce2f91efea539fabec73db4e2
b7f8b8f403106b5346c2fb6ddf971fd1
cf2ab220ba3885e3a296d08424f01372
cafa7fc1c1b7d0180442c366ad7b56ef
0094608f084f85e9fe2fa973c456a421
9da9bcfc2424f41ec55d577d32d1e449
2b0795ea987aff4dc1a53b3713b51a15
5d74013d27c26cc88fcd1e0286ee3b60
09b01b20f38cfaf898b724fb7fcd2663


Decrypted text (no newline):
This is an unusual paragraph. I'm curious how quickly you can find out what is so unusual
about it? It looks so plain you would think nothing was wrong with it! In fact, nothing
is wrong with it! It is unusual though. Study it, and think about it, but you still may
not find anything odd. But if you work at it a bit, you might find out! Try to do so without
any coaching! You most probably won't, at first, find anything particularly odd or unusual
or in any way dissimilar to any ordinary composition. That is not at all surprising, for it
is no strain to accomplish in so short a paragraph a stunt similar to that which an author
did throughout all of his book, without spoiling a good writing job, and it was no small
book at that. 

'''

AES_modulus = BitVector(bitstring = '100011011')    #irriversible polynomial
bytesubtable = []       #for encryption
invbytesubtable = []    #for decryption
key = "yayboilermakers!"

##############################################
##read plaintext from file
##############################################
def getplaintext():
    File = open("plaintext.txt", "r")  #File is the file that contains the text
    plaintext = keyFile.read()         #stores the plaintext in a string
    File.close()
    return plaintext

##############################################
##generate the key schedule, our key is "yayboilermakers!",
##128 bits.
##############################################
def getkeyschedule():
    keybv = BitVector(textstring = key)
    #  We need 44 keywords in the key schedule for 128 bit AES.  Each keyword is 32-bits
    #  wide. The 128-bit AES uses the first four keywords to xor the input block with.
    #  Subsequently, each of the 10 rounds uses 4 keywords from the key schedule. We will
    #  store all 44 keywords in the following list:
    keywords = [None for i in range(44)]
    roundconstant = BitVector(intVal = 1, size = 8)
    for i in range(4):
        #Takes 4 byte each time for each word, for the first 4 words
        keywords[i] = keybv[i*32 : i*32 + 32]
    #Now the rest of the words (4 to 43)
    for i in range(4,44):
        #If it is the first one, xor the first word from previous and gfunction
        if i%4 == 0:
            gword, roundconstant = gfunction(keywords[i-1], roundconstant, bytesubtable)
            keywords[i] = gword ^ keywords[i-4]
        else:
        #else xor the previous and 4 words ago
            keywords[i] = keywords[i-4] ^ keywords[i-1]
    return keywords

##############################################
##g function for xor in generating the keys
##############################################        
def gfunction(keyword, roundconstant, bytesubtable):
    rotate = keyword.deep_copy()
    #shift rotate 1 byte left
    rotate << 8
    gword = BitVector(size = 0)
    #byte substitution for each byte
    for i in range(4):
        gword += BitVector(intVal = bytesubtable[rotate[i*8 : i*8 + 8].intValue()], size = 8)
    gword[:8] ^= roundconstant
    #update roundconstant for next round
    roundconstant = roundconstant.gf_multiply_modular(BitVector(intVal = 0x02), AES_modulus, 8)
    return gword, roundconstant

##############################################
##generate the subbytes and invsubbytes table (given in lecture notes)
##############################################
def genTables():
    c = BitVector(bitstring='01100011') #special constant byte
    d = BitVector(bitstring='00000101') #special constant byte
    for i in range(0, 256):
        # For the encryption SBox
        #get the multiplicative inverse of a in G(2^8), 0 has no MI
        a = BitVector(intVal = i, size=8).gf_MI(AES_modulus, 8) if i != 0 else BitVector(intVal=0)
        # For bit scrambling for the encryption SBox entries:
        a1,a2,a3,a4 = [a.deep_copy() for x in range(4)]
        a ^= (a1 >> 4) ^ (a2 >> 5) ^ (a3 >> 6) ^ (a4 >> 7) ^ c
        bytesubtable.append(int(a))
        # For the decryption Sbox:
        b = BitVector(intVal = i, size=8)
        # For bit scrambling for the decryption SBox entries:
        b1,b2,b3 = [b.deep_copy() for x in range(3)]
        b = (b1 >> 2) ^ (b2 >> 5) ^ (b3 >> 7) ^ d
        check = b.gf_MI(AES_modulus, 8)
        b = check if isinstance(check, BitVector) else 0
        invbytesubtable.append(int(b))
        
##############################################
##Take the bitvector and make it into a 4x4 statearray
##############################################
def makestatearray(inBV):
    allbytes = []
    for i in range(0,128,8):
        allbytes.append(inBV[i:i+8])
    statearray = []
    for i in range(4):
        statearray.append([allbytes[i], allbytes[i+4], allbytes[i+8], allbytes[i+12]])
    return statearray

##############################################
##substitution lookup table and return substituted state array,
##encryptdecrypt for choosing which table to use, 0 encrypt, 1 decrypt
##############################################
def substitution(statearray, encryptdecrypt):
    substitutestatearray = [[None for i in range(4)] for j in range(4)]
    #Go through all rows
    for i, byterows in enumerate(statearray):
        #Go through all bytes
        for j, byte in enumerate(byterows):
            #Get column and row and lookup table
            [row, col] = byte.divide_into_two()
            if (encryptdecrypt == 0):
                bytesub = bytesubtable[int(row)*16 + int(col)]
            elif (encryptdecrypt == 1):
                bytesub = invbytesubtable[int(row)*16 + int(col)]
            substitutestatearray[i][j] = BitVector(intVal = bytesub, size = 8)
    return(substitutestatearray)

##############################################
##shifts the rows of the state array,
##encryptdecrypt for choosing which table to use, 0 encrypt, 1 decrypt
##############################################         
def shiftrows(statearray, encryptdecrypt):
    row0 = statearray[0]
    row1 = statearray[1]
    row2 = statearray[2]
    row3 = statearray[3]
    if (encryptdecrypt == 0):
        r1 = [row1[1],row1[2],row1[3],row1[0]]
        r2 = [row2[2],row2[3],row2[0],row2[1]]
        r3 = [row3[3],row3[0],row3[1],row3[2]]
        shiftedrows = [row0, r1, r2, r3]
    elif (encryptdecrypt == 1):
        r1 = [row1[3],row1[0],row1[1],row1[2]]
        r2 = [row2[2],row2[3],row2[0],row2[1]]
        r3 = [row3[1],row3[2],row3[3],row3[0]]
        shiftedrows = [row0, r1, r2, r3]
    return shiftedrows

##############################################
##Mixes the columns
##encryptdecrypt for choosing which table to use, 0 encrypt, 1 decrypt
##############################################  
def mixcol(statearray, encryptdecrypt):
    mixcolstatearray = [[None for i in range(4)] for j in range(4)]
    stateArr = [[None for i in range(4)] for j in range(4)]
    hex1 = BitVector(hexstring = "01")  #Declare all as bitvector
    hex2 = BitVector(hexstring = "02")
    hex3 = BitVector(hexstring = "03")
    hexE = BitVector(hexstring = '0e')
    hexB = BitVector(hexstring = '0b')
    hexD = BitVector(hexstring = '0d')
    hex9 = BitVector(hexstring = '09')
    if (encryptdecrypt == 0):
        matrix = [[hex2, hex3, hex1, hex1],
                  [hex1, hex2, hex3, hex1],
                  [hex1, hex1, hex2, hex3],
                  [hex3, hex1, hex1, hex2]]
    elif (encryptdecrypt == 1):
        matrix = [[hexE, hexB, hexD, hex9],
                  [hex9, hexE, hexB, hexD],
                  [hexD, hex9, hexE, hexB],
                  [hexB, hexD, hex9, hexE]]
    for i in range (4):
        for j in range (4):
            stateArr[i][j] = statearray[j][i] #Make columns into rows for easier multiplication          
    
    for i in range (4):
        for j in range (4):
            mixcolstatearray[i][j] = matrixmultiply(matrix[i], stateArr[j])    

    return mixcolstatearray


##############################################
##helps multiply and xor the two given rows
##############################################  
def matrixmultiply(row1, row2):
    col = row1[0].gf_multiply_modular(row2[0], AES_modulus, 8)
    for i in range(1,4):
        product = row1[i].gf_multiply_modular(row2[i], AES_modulus, 8)
        col ^= product
    return col

##############################################
##Take the statearray and makes it bitvector
##############################################
def makeBV(statearray):
    BV = BitVector(size=0)
    stateArr = [[None for i in range(4)] for j in range(4)]
    for i in range (4):
        for j in range (4):
            stateArr[i][j] = statearray[j][i]
    for i in stateArr:
        for j in i:
            BV += j
    return BV

##############################################
##Setup for encrypting and decrypting: get the round keys
##############################################
def setup():
    ''' To get the words from key schedule'''
    genTables()
    keywords = getkeyschedule()
    key_schedule = []
    for word_index, word in enumerate(keywords):
        keywordints = []
        for i in range(4):
            keywordints.append(word[i*8 : i*8 + 8 ].intValue())
        key_schedule.append(keywordints)
    ##To get the round keys in hex 
    roundkeys = [None for i in range(11)]
    for i in range(11):
            roundkeys[i] = (keywords[i*4] + keywords[i*4+1] + keywords[i*4+2] + keywords[i*4+3])
    return roundkeys


##############################################
##AES encryption
##############################################
def encrypt():
    roundkeys = setup()
    #intextBV = BitVector(filename = "plaintext.txt")
    intextBV = BitVector(filename = "plaintext2.txt")
    outFile = open("encrypted2.txt", "w")
    cleartext = ""
    outFile.write(cleartext)
    outFile.close()
    while (intextBV.more_to_read):
        inBV = intextBV.read_bits_from_file(128)
        #If the plaintextvec is not 128 bits, add padding
        while (len(inBV) < 128):
            inBV.pad_from_right(8)
        #Add round key first (words 0 to word 3)
        inBV ^= roundkeys[0]
        for rounds in range(1, 11):
            statearray = makestatearray(inBV)
            statearray = substitution(statearray, 0)
            statearray = shiftrows(statearray, 0)
            if (rounds != 10):
                statearray = mixcol(statearray, 0)
            inBV = makeBV(statearray)
            inBV ^= roundkeys[rounds]
        outFile = open("encrypted.txt", 'ab')   #outFile is the file that contains the resulted text
        inBV.write_to_file(outFile)
        outFile.close()        
    intextBV.close_file_object()

##############################################
##AES decryption
##############################################
def decrypt():
    roundkeys = setup()
    intextBV = BitVector(filename = "encrypted.txt")
    outFile = open("decrypted.txt", "w")
    cleartext = ""
    outFile.write(cleartext)
    outFile.close()
    while (intextBV.more_to_read):
        inBV = intextBV.read_bits_from_file(128)
        #Add round key first (words 0 to word 3)
        inBV ^= roundkeys[10]
        for rounds in range(1,11):
            statearray = makestatearray(inBV)
            statearray = shiftrows(statearray, 1)
            statearray = substitution(statearray, 1)
            inBV = makeBV(statearray)
            inBV ^= roundkeys[10 - rounds]
            statearray = makestatearray(inBV)
            if (rounds != 10):
                statearray = mixcol(statearray, 1)
            inBV = makeBV(statearray)
        outFile = open("decrypted.txt", 'ab')   #outFile is the file that contains the resulted text
        inBV.write_to_file(outFile)
        outFile.close()        
    intextBV.close_file_object()
            
def print_genTables():
    genTables()    

    bs = bytesubtable
    ibs = invbytesubtable
    
    bs_str = "{{{"
    count = 0
    for idx in range(len(bs)):
        bs_str += "8'b{0:08b}".format(bs[idx])
        if idx == 255:
            bs_str += "}}}"
        elif idx % 16 == 15:
            bs_str += "}},{{"
        elif idx % 4 == 3:
            bs_str += "},{"
        else:
            bs_str += "," 


    ibs_str = "{{{"
    count = 0
    for idx in range(len(ibs)):
        ibs_str += "8'b{0:08b}".format(ibs[idx])
        if idx == 255:
            ibs_str += "}}}"
        elif idx % 16 == 15:
            ibs_str += "}},{{"
        elif idx % 4 == 3:
            ibs_str += "},{"
        else:
            ibs_str += "," 

    print("BS",bs_str)
    print("IBS",ibs_str)        

if __name__ == "__main__":
    
    #print_genTables()
    encrypt()
    #decrypt()
    
