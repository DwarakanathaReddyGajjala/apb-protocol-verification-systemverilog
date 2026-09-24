# APB Protocol Verification using SystemVerilog

## Overview

This project implements a SystemVerilog-based verification environment for an APB slave using an APB master and a layered testbench.

The testbench generates and drives APB read and write transactions to the APB slave, monitors the completed transfers, and checks the expected results using a scoreboard.

The verification environment validates functional correctness and data integrity through transaction generation, driving, monitoring, and scoreboard-based checking.

---

## Verification Components

- **APB Transaction** – Defines the APB read/write transaction.
- **APB Generator** – Generates APB transactions for different test scenarios.
- **APB Driver** – Drives transactions onto the APB interface.
- **APB Monitor** – Monitors APB transfers and captures completed transactions.
- **APB Scoreboard** – Compares expected and observed results to check data correctness.
- **APB Environment** – Connects the verification components.
- **APB Tests** – Controls different read/write test scenarios.
- **APB Slave** – Design Under Test (DUT).

---

## Test Scenarios

The testbench includes:

1. **Write-only operation**
2. **Read-only operation**
3. **Random read and write operations**
4. **Write followed by read**
5. **Reset condition**
6. **Multiple writes followed by reads from the same addresses**

---

## Files

### APB_Master

1. `APB_Interface.sv` – APB interface connecting the testbench and slave
2. `APB_Transaction.sv` – APB transaction class
3. `APB_Generator.sv` – Generates APB transactions
4. `APB_Driver.sv` – Drives transactions onto the APB interface
5. `APB_Monitor.sv` – Monitors APB transfers
6. `APB_Score_Board.sv` – Checks expected and observed transaction results
7. `APB_Env.sv` – Verification environment
8. `APB_Base_Test.sv` – Base test class
9. `APB_Write_Test.sv` – Write operation test
10. `APB_Read_Test.sv` – Read operation test
11. `testbench.sv` – Top-level testbench

### APB_Slave

1. `APB_Slave.sv` – APB slave design under test

---

## How to Run

### Using VCS

1. Compile the APB slave and testbench SystemVerilog files.
2. Select `testbench` as the top-level module.
3. Run the required test scenario.
4. Check the simulation output and waveforms.

---

## Technologies & Protocols

- **SystemVerilog** → Hardware Verification Language
- **VCS** → EDA Tool
- **APB** → Protocol
