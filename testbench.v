module test;
    reg           clk = 0;
    wire [7:0]    regA_out;
    wire [7:0]    regB_out;

    reg           mov_test_failed = 1'b0;
    reg           reg_mov_test_failed = 1'b0;
    reg           add_test_failed = 1'b0;
    reg           sub_test_failed = 1'b0;
    reg           and_test_failed = 1'b0;
    reg           or_test_failed = 1'b0;
    reg           not_test_failed = 1'b0;
    reg           xor_test_failed = 1'b0;
    reg           shl_test_failed = 1'b0;
    reg           shr_test_failed = 1'b0;
    reg           inc_test_failed = 1'b0;
    reg           mem_mov_test_failed = 1'b0;
    reg           indirect_mov_test_failed = 1'b0;
    reg           mem_add_test_failed = 1'b0;
    reg           mem_sub_test_failed = 1'b0;
    reg           mem_and_test_failed = 1'b0;
    reg           mem_or_test_failed = 1'b0;
    reg           mem_not_test_failed = 1'b0;
    reg           mem_xor_test_failed = 1'b0;
    reg           mem_shl_test_failed = 1'b0;
    reg           mem_shr_test_failed = 1'b0;
    reg           mem_inc_test_failed = 1'b0;
    reg           mem_rst_test_failed = 1'b0;

    // ------------------------------------------------------------
    // IMPORTANTE!! Editar con el modulo de su computador
    // ------------------------------------------------------------
    computer Comp(.clk(clk));
    // ------------------------------------------------------------

    // ------------------------------------------------------------
    // IMPORTANTE!! Editar para que la variable apunte a la salida
    // de los registros de su computador.
    // ------------------------------------------------------------
    assign regA_out = Comp.regA.out;
    assign regB_out = Comp.regB.out;
    // ------------------------------------------------------------

    initial begin
        $dumpfile("out/dump.vcd");
        $dumpvars(0, test);
        $readmemb("im.dat", Comp.IM.mem);

        // --- Test 0: MOV Literal Instructions ---
        $display("\n----- STARTING TEST 0: MOV A,Lit & MOV B,Lit -----");
        $display("  Sub-test: MOV A, 42. Initial A=%d", regA_out);
        #3; if (regA_out !== 8'd42) mov_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 42.", regA_out);
        $display("  Sub-test: MOV B, 123. Initial B=%d", regB_out);
        #2; if (regB_out !== 8'd123) mov_test_failed = 1'b1;
        $display("  Result: B = %d. Expected 123.", regB_out);
        if (!mov_test_failed) $display(">>>>> MOV TEST PASSED! <<<<<" ); else $display(">>>>> MOV TEST FAILED! <<<<< ");

        // --- Test 1: Register-to-Register MOV Instructions ---
        $display("\n----- STARTING TEST 1: MOV A,B & MOV B,A -----");
        #10; // 5 instructions
        $display("  Final state after 5 MOV instructions: regA=%d, regB=%d", regA_out, regB_out);
        if (!reg_mov_test_failed) $display(">>>>> REGISTER MOV TEST PASSED! <<<<< "); else $display(">>>>> REGISTER MOV TEST FAILED! <<<<< ");

        // --- Test 2: ADD Instructions (Register and Literal) ---
        $display("\n----- STARTING TEST 2: ADD Instructions -----");
        #10; // 5 instructions
        $display("  Final state after 5 ADD instructions: regA=%d, regB=%d", regA_out, regB_out);
        if (!add_test_failed) $display(">>>>> ALL ADD TESTS PASSED! <<<<< "); else $display(">>>>> ADD TEST FAILED! <<<<< ");

        // --- Test 3: SUB Instructions ---
        $display("\n----- STARTING TEST 3: All SUB Instructions -----");
        #12; // 6 instructions
        $display("  Final state after 6 SUB instructions: regA=%d, regB=%d", regA_out, regB_out);
        if (!sub_test_failed) $display(">>>>> ALL SUB TESTS PASSED! <<<<< "); else $display(">>>>> SUB TEST FAILED! <<<<< ");

        // --- Test 4: AND Instructions ---
        $display("\n----- STARTING TEST 4: All AND Instructions -----");
        #16; // 8 instructions
        $display("  Final state after 8 AND instructions: regA=%d, regB=%d", regA_out, regB_out);
        if (!and_test_failed) $display(">>>>> ALL AND TESTS PASSED! <<<<< "); else $display(">>>>> AND TEST FAILED! <<<<< ");

        // --- Test 5: OR Instructions ---
        $display("\n----- STARTING TEST 5: All OR Instructions -----");
        #16; // 8 instructions
        $display("  Final state after 8 OR instructions: regA=%d, regB=%d", regA_out, regB_out);
        if (!or_test_failed) $display(">>>>> ALL OR TESTS PASSED! <<<<< "); else $display(">>>>> OR TEST FAILED! <<<<< ");

        // --- Test 6: NOT Instructions ---
        $display("\n----- STARTING TEST 6: All NOT Instructions -----");
        #20; // 10 instructions
        $display("  Final state after 10 NOT instructions: regA=%d, regB=%d", regA_out, regB_out);
        if (!not_test_failed) $display(">>>>> ALL NOT TESTS PASSED! <<<<< "); else $display(">>>>> NOT TEST FAILED! <<<<< ");

        // --- Test 7: XOR Instructions ---
        $display("\n----- STARTING TEST 7: All XOR Instructions -----");
        #22; // 11 instructions
        $display("  Final state after 11 XOR instructions: regA=%d, regB=%d", regA_out, regB_out);
        if (!xor_test_failed) $display(">>>>> ALL XOR TESTS PASSED! <<<<< "); else $display(">>>>> XOR TEST FAILED! <<<<< ");

        // --- Test 8: SHL Instructions  ---
        $display("\n----- STARTING TEST 8: All SHL Instructions -----");
        #26; // 13 instructions
        $display("  Final state after 13 SHL instructions: regA=%d, regB=%d", regA_out, regB_out);
        if (!shl_test_failed) $display(">>>>> ALL SHL TESTS PASSED! <<<<< "); else $display(">>>>> SHL TEST FAILED! <<<<< ");

        // --- Test 9: SHR Instructions ---
        $display("\n----- STARTING TEST 9: All SHR Instructions -----");
        #26; // 13 instructions
        $display("  Final state after 13 SHR instructions: regA=%d, regB=%d", regA_out, regB_out);
        if (!shr_test_failed) $display(">>>>> ALL SHR TESTS PASSED! <<<<< "); else $display(">>>>> SHR TEST FAILED! <<<<< ");

        // --- Test 10: INC B Instruction ---
        $display("\n----- STARTING TEST 10: INC B Instruction -----");
        #12; // 6 instructions
        $display("  Final state after 6 INC instructions: regA=%d, regB=%d", regA_out, regB_out);
        if (!inc_test_failed) $display(">>>>> ALL INC TESTS PASSED! <<<<< "); else $display(">>>>> INC TEST FAILED! <<<<< ");

        // --- Test 11: Data Memory MOV Instructions ---
        $display("\n----- STARTING TEST 11: Data Memory MOV Instructions -----");
        #2; // MOV A, 101
        #2; // MOV B, 202
        #2; // MOV (20), A
        $display("  Sub-test: MOV (Dir),A. Storing A(101) in Mem[20].");
        #2; // MOV (21), B
        $display("  Sub-test: MOV (Dir),B. Storing B(202) in Mem[21].");
        #2; // MOV A, 0
        #2; // MOV B, 0
        #2; // MOV A, (21)
        $display("  Sub-test: MOV A,(Dir). Loading from Mem[21]. Initial A=%d", regA_out);
        if (regA_out !== 8'd202) mem_mov_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 202.", regA_out);
        #2; // MOV B, (20)
        $display("  Sub-test: MOV B,(Dir). Loading from Mem[20]. Initial B=%d", regB_out);
        if (regB_out !== 8'd101) mem_mov_test_failed = 1'b1;
        $display("  Result: B = %d. Expected 101.", regB_out);
        if (!mem_mov_test_failed) $display(">>>>> ALL MEMORY MOV TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY MOV TEST FAILED! <<<<< ");

        // --- Test 12: Register Indirect MOV ---
        $display("\n----- STARTING TEST 12: Register Indirect MOV -----");
        #2; // MOV A, 111
        #2; // MOV B, 50
        #2; // MOV (B), A
        $display("  Sub-test: MOV (B),A. Storing A(111) in Mem[B(50)].");
        #2; // MOV A, 0
        #2; // MOV A, (B)
        $display("  Sub-test: MOV A,(B). Loading from Mem[B(50)]. Initial A=%d", regA_out);
        if (regA_out !== 8'd111) indirect_mov_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 111.", regA_out);
        #2; // MOV A, 60
        #2; // MOV B, 222
        #2; // MOV (60), B
        #2; // MOV B, 0
        #2; // MOV B, (A)
        $display("  Sub-test: MOV B,(A). Loading from Mem[A(60)]. Initial B=%d", regB_out);
        if (regB_out !== 8'd222) indirect_mov_test_failed = 1'b1;
        $display("  Result: B = %d. Expected 222.", regB_out);
        if (!indirect_mov_test_failed) $display(">>>>> ALL INDIRECT MOV TESTS PASSED! <<<<< "); else $display(">>>>> INDIRECT MOV TEST FAILED! <<<<< ");

        // --- Test 13: Memory ADD ---
        $display("\n----- STARTING TEST 13: Memory ADD -----");
        $display("  Sub-test: ADD A,(Dir). Initial A=%d", regA_out);
        #8; // ADD A,(Dir)
        if (regA_out !== 8'd30) mem_add_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 30.", regA_out);
        $display("  Sub-test: ADD B,(Dir). Initial B=%d", regB_out);
        #8; // ADD B,(Dir)
        if (regB_out !== 8'd40) mem_add_test_failed = 1'b1;
        $display("  Result: B = %d. Expected 40.", regB_out);
        $display("  Sub-test: ADD A,(B). Initial A=%d", regA_out);
        #8; // ADD A,(B)
        if (regA_out !== 8'd10) mem_add_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 10.", regA_out);
        $display("  Sub-test: ADD (Dir). Value in Mem[10] will be A+B.");
        #8; // ADD (Dir)
        if (regA_out !== 8'd15) mem_add_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 15 (value from Mem[10]).", regA_out);
        if (!mem_add_test_failed) $display(">>>>> ALL MEMORY ADD TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY ADD TEST FAILED! <<<<< ");

        // --- Test 14: Memory SUB ---
        $display("\n----- STARTING TEST 14: Memory SUB -----");
        $display("  Sub-test: SUB A,(Dir). Initial A=%d", regA_out);
        #8; // SUB A,(Dir)
        if (regA_out !== 8'd70) mem_sub_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 70.", regA_out);
        $display("  Sub-test: SUB B,(Dir). Initial B=%d", regB_out);
        #8; // SUB B,(Dir)
        if (regB_out !== 8'd25) mem_sub_test_failed = 1'b1;
        $display("  Result: B = %d. Expected 25.", regB_out);
        $display("  Sub-test: SUB A,(B). Initial A=%d", regA_out);
        #10; // SUB A,(B)
        if (regA_out !== 8'd10) mem_sub_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 10.", regA_out);
        $display("  Sub-test: SUB (Dir). Value in Mem[11] will be A-B.");
        #8; // SUB (Dir)
        if (regA_out !== 8'd10) mem_sub_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 10 (value from Mem[11]).", regA_out);
        if (!mem_sub_test_failed) $display(">>>>> ALL MEMORY SUB TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY SUB TEST FAILED! <<<<< ");

        // --- Test 15: Memory AND ---
        $display("\n----- STARTING TEST 15: Memory AND -----");
        $display("  Sub-test: AND A,(Dir). Initial A=%d", regA_out);
        #8;
        if (regA_out !== 8'd136) mem_and_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 136.", regA_out);
        if (!mem_and_test_failed) $display(">>>>> ALL MEMORY AND TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY AND TEST FAILED! <<<<< ");

        // --- Test 16: Memory OR ---
        $display("\n----- STARTING TEST 16: Memory OR -----");
        $display("  Sub-test: OR B,(Dir). Initial B=%d", regB_out);
        #8;
        if (regB_out !== 8'd238) mem_or_test_failed = 1'b1;
        $display("  Result: B = %d. Expected 238.", regB_out);
        if (!mem_or_test_failed) $display(">>>>> ALL MEMORY OR TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY OR TEST FAILED! <<<<< ");

        // --- Test 17: Memory NOT ---
        $display("\n----- STARTING TEST 17: Memory NOT -----");
        $display("  Sub-test: NOT (Dir),A. Mem[13] will be ~A.");
        #6;
        if (regA_out !== 8'd85) mem_not_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 85 (value from Mem[13]).", regA_out);
        if (!mem_not_test_failed) $display(">>>>> ALL MEMORY NOT TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY NOT TEST FAILED! <<<<< ");

        // --- Test 18: Memory XOR ---
        $display("\n----- STARTING TEST 18: Memory XOR -----");
        $display("  Sub-test: XOR A,(Dir). Initial A=%d", regA_out);
        #10;
        if (regA_out !== 8'd102) mem_xor_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 102.", regA_out);
        if (!mem_xor_test_failed) $display(">>>>> ALL MEMORY XOR TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY XOR TEST FAILED! <<<<< ");

        // --- Test 19: Memory SHL ---
        $display("\n----- STARTING TEST 19: Memory SHL -----");
        $display("  Sub-test: SHL (Dir),A. Mem[15] will be A << 1.");
        #6;
        if (regA_out !== 8'd170) mem_shl_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 170 (value from Mem[15]).", regA_out);
        if (!mem_shl_test_failed) $display(">>>>> ALL MEMORY SHL TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY SHL TEST FAILED! <<<<< ");

        // --- Test 20: Memory SHR ---
        $display("\n----- STARTING TEST 20: Memory SHR -----");
        $display("  Sub-test: SHR (Dir),B. Mem[16] will be B >> 1.");
        #6;
        if (regB_out !== 8'd102) mem_shr_test_failed = 1'b1;
        $display("  Result: B = %d. Expected 102 (value from Mem[16]).", regB_out);
        if (!mem_shr_test_failed) $display(">>>>> ALL MEMORY SHR TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY SHR TEST FAILED! <<<<< ");

        // --- Test 21: Memory INC ---
        $display("\n----- STARTING TEST 21: Memory INC -----");
        $display("  Sub-test: INC (Dir). Mem[100] will be incremented.");
        #8;
        if (regA_out !== 8'd100) mem_inc_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 100 (value from Mem[100]).", regA_out);
        if (!mem_inc_test_failed) $display(">>>>> ALL MEMORY INC TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY INC TEST FAILED! <<<<< ");

        // --- Test 22: Memory RST ---
        $display("\n----- STARTING TEST 22: Memory RST -----");
        $display("  Sub-test: RST (Dir). Mem[101] will be reset to 0.");
        #6;
        if (regA_out !== 8'd0) mem_rst_test_failed = 1'b1;
        $display("  Result: A = %d. Expected 0 (value from Mem[101]).", regA_out);
        if (!mem_rst_test_failed) $display(">>>>> ALL MEMORY RST TESTS PASSED! <<<<< "); else $display(">>>>> MEMORY RST FAILED! <<<<< ");

        #2;
        $finish;
    end

    // Clock Generator
    always #1 clk = ~clk;

endmodule
