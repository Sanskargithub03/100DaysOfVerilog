# Day 2 - 8:1 Multiplexer using 2:1 Multiplexers

## 📘 Concept
A **Multiplexer (MUX)** selects one input from many inputs and forwards it to the output, based on select lines.  
- An **8:1 MUX** has **8 inputs**, **3 select lines**, and **1 output**.  
- Instead of designing it directly, we build it using smaller **2:1 MUXes**.  

### ⚙️ Structure
- Each **2:1 MUX** takes 2 inputs and 1 select line.  
- To design an **8:1 MUX**, we combine multiple **2:1 MUXes** in a tree structure:  
  - **First level:** 4 MUXes select from 8 inputs → 4 outputs.  
  - **Second level:** 2 MUXes select from 4 outputs → 2 outputs.  
  - **Final level:** 1 MUX selects from 2 outputs → Final output.  

This way, we use **7 instances of 2:1 MUXes**.

### 📝 Truth Table (8:1 MUX)
| Select Lines (S2 S1 S0) | Output (Y) |
|--------------------------|------------|
| 000 | I0 |
| 001 | I1 |
| 010 | I2 |
| 011 | I3 |
| 100 | I4 |
| 101 | I5 |
| 110 | I6 |
| 111 | I7 |

### 🖥️ Verilog Code Structure
1. Write a module for a **2:1 MUX**.  
2. Instantiate **7 such 2:1 MUX modules** to build the **8:1 MUX**.  

Example outline:
```verilog
module mux2to1 (input a, input b, input sel, output y);
    assign y = sel ? b : a;
endmodule

module mux8to1 (input [7:0] I, input [2:0] S, output Y);
    wire [3:0] w;
    wire [1:0] x;

    mux2to1 m1(I[0], I[1], S[0], w[0]);
    mux2to1 m2(I[2], I[3], S[0], w[1]);
    mux2to1 m3(I[4], I[5], S[0], w[2]);
    mux2to1 m4(I[6], I[7], S[0], w[3]);

    mux2to1 m5(w[0], w[1], S[1], x[0]);
    mux2to1 m6(w[2], w[3], S[1], x[1]);

    mux2to1 m7(x[0], x[1], S[2], Y);
endmodule
