module AES(
    input enable, 
    output wire e128, 
    output wire d128, 
    output wire e192, 
    output wire d192, 
    output wire e256, 
    output wire d256
);

// The plain text used as input
wire [127:0] in = 128'h4B61727468696B2052616A616E0000000000000000000000;

;

// The different keys used for testing (one of each type)
wire[127:0] key128 = 128'h000102030405060708090a0b0c0d0e0f;
wire[191:0] key192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
wire[255:0] key256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

// The result of the encryption module for every type
wire[127:0] encrypted128;
wire[127:0] encrypted192;
wire[127:0] encrypted256;

// The result of the decryption module for every type
wire[127:0] decrypted128;
wire[127:0] decrypted192;
wire[127:0] decrypted256;

// Assign the encrypted values as the expected output automatically
wire[127:0] expected128 = encrypted128;
wire[127:0] expected192 = encrypted192;
wire[127:0] expected256 = encrypted256;

// Encryptions
AES_Encrypt a(in, key128, encrypted128);
AES_Encrypt #(192, 12, 6) b(in, key192, encrypted192);
AES_Encrypt #(256, 14, 8) c(in, key256, encrypted256);

// Decryptions
AES_Decrypt a2(encrypted128, key128, decrypted128);
AES_Decrypt #(192, 12, 6) b2(encrypted192, key192, decrypted192);
AES_Decrypt #(256, 14, 8) c2(encrypted256, key256, decrypted256);

// Comparison to determine if encryption and decryption were successful
assign e128 = (encrypted128 == expected128 && enable) ? 1'b1 : 1'b0;
assign e192 = (encrypted192 == expected192 && enable) ? 1'b1 : 1'b0;
assign e256 = (encrypted256 == expected256 && enable) ? 1'b1 : 1'b0;

assign d128 = (decrypted128 == in && enable) ? 1'b1 : 1'b0;
assign d192 = (decrypted192 == in && enable) ? 1'b1 : 1'b0;
assign d256 = (decrypted256 == in && enable) ? 1'b1 : 1'b0;

endmodule
