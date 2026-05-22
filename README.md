# SPI Controller (Serial Peripheral Interface)

## Overview
This project implements an SPI (Serial Peripheral Interface) Controller using Verilog HDL. The design supports single master–single slave communication with configurable SPI modes and baud rate generation.

The SPI controller includes master control logic, baud rate generator, phase and polarity control, shift register–based data transfer, and status/control registers. The architecture was designed and verified using Vivado simulation.

---

## Features
- SPI Master Controller Design
- Single Master – Single Slave Communication
- Configurable CPOL and CPHA Modes
- Configurable Baud Rate Generator
- MSB First and LSB First Data Transfer
- Shift Register–Based Serial Communication
- Full Duplex Data Transfer
- SPI Status and Control Registers
- Verilog RTL Design
- Verified using Vivado Simulation

---

## SPI Signals

### SPI Interface Signals
- MOSI  → Master Out Slave In
- MISO  → Master In Slave Out
- SCK   → Serial Clock
- SS    → Slave Select

### Control Signals
- CPOL  → Clock Polarity
- CPHA  → Clock Phase
- SPE   → SPI Enable
- MSTR  → Master Mode Select

---

## SPI Architecture

The SPI controller architecture includes:

### 1. SPI Control Registers
- SPI Control Register 1
- SPI Control Register 2
- SPI Status Register
- SPI Baud Rate Register
- SPI Data Register
- SPI Received Register

### 2. Baud Rate Generator
- Generates SPI serial clock from system clock
- Supports configurable clock division

### 3. Master Control Unit
- Controls SPI transmission process
- Handles enable logic and bit counting
- Generates shift and sample clocks

### 4. Phase & Polarity Control
- Controls SPI mode operation using CPOL and CPHA
- Generates SCK according to selected SPI mode

### 5. Shift Register Logic
- Performs serial-to-parallel and parallel-to-serial conversion
- Supports both MSB-first and LSB-first transmission

---

## Supported SPI Modes

| SPI Mode | CPOL | CPHA |
|----------|------|------|
| Mode 0   | 0    | 0    |
| Mode 1   | 0    | 1    |
| Mode 2   | 1    | 0    |
| Mode 3   | 1    | 1    |

---

## Data Transfer Operation

### Write/Transmit Operation
1. Data is loaded into SPI Data Register
2. Master asserts Slave Select (SS)
3. Shift register transmits data serially through MOSI
4. Clock pulses generated on SCK
5. Transfer completes after all bits are transmitted

### Receive Operation
1. Incoming serial data received through MISO
2. Data sampled using sample clock
3. Received data stored into SPI Received Register

---

## Tools Used
- Verilog HDL
- Xilinx Vivado
- Verilog Testbench

---

## Project Structure

```text
├── rtl/
│   ├── spi_master.v
│   ├── baud_rate_generator.v
│   ├── phase_polarity_control.v
│   ├── shift_register.v
│   ├── spi_registers.v
│   ├── spi_top.v
│
├── testbench/
│   └── tb_spi_top.v
│
├── architecture/
│   └── spi_architecture.png
│
├── simulation/
│   └── waveform.png
│
└── README.md
