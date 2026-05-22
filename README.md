# SPI Controller (Serial Peripheral Interface)

## Overview
This project implements a complete SPI (Serial Peripheral Interface) Controller using Verilog HDL. The design supports single master–single slave communication with configurable SPI operating modes and baud rate control.

The SPI controller includes master and slave modules, baud rate generator, clock polarity and phase control, shift register–based transmission/reception, and SPI control/status registers. The design is verified using Verilog testbenches in Xilinx Vivado.

---

## Features
- SPI Master and SPI Slave Design
- Single Master – Single Slave Communication
- Configurable CPOL and CPHA Modes
- Adjustable Baud Rate Generator
- Full Duplex Serial Communication
- MSB First and LSB First Data Transfer
- Shift Register–Based Data Transmission
- SPI Status and Control Registers
- Verilog RTL Design
- Verified using Vivado Simulation

---

## SPI Interface Signals

| Signal | Description |
|--------|-------------|
| MOSI | Master Out Slave In |
| MISO | Master In Slave Out |
| SCK  | Serial Clock |
| SS   | Slave Select |

---

## Control Signals

| Signal | Description |
|--------|-------------|
| CPOL | Clock Polarity |
| CPHA | Clock Phase |
| SPE  | SPI Enable |
| MSTR | Master Mode Select |

---

## SPI Architecture

The SPI architecture consists of:
- SPI Master Module
- SPI Slave Module
- Master Control Unit
- Baud Rate Generator
- Clock Polarity and Phase Control
- Shift Registers
- SPI Data Registers
- SPI Status Registers
- SPI Port Logic

The architecture supports configurable SPI modes and serial communication between master and slave devices.

---

## Supported SPI Modes

| SPI Mode | CPOL | CPHA |
|----------|------|------|
| Mode 0 | 0 | 0 |
| Mode 1 | 0 | 1 |
| Mode 2 | 1 | 0 |
| Mode 3 | 1 | 1 |

---

## Data Transfer Operation

### Transmission
1. Parallel data is loaded into the data register.
2. Slave Select (SS) is activated.
3. SPI clock (SCK) is generated using baud rate generator.
4. Data is shifted serially through MOSI.
5. Receiver samples incoming data using selected SPI mode.

### Reception
1. Serial data is received through MISO.
2. Data is shifted into receive shift register.
3. Parallel received data is stored into receive register.

---

## Project Structure

```text
├── rtl/
│   ├── Master_control.v
│   ├── SPI_MASTER.v
│   ├── SPI_SLAVE.v
│   ├── baud_rate_generator.v
│   ├── baud_rate_register.v
│   ├── clock_polarity_receiver.v
│   ├── clock_polarity_transmitter.v
│   ├── contol_register1.v
│   ├── control_register2.v
│   ├── data_register.v
│   ├── port_logic.v
│   ├── port_logic_slave.v
│   ├── shift_register.v
│   ├── shift_register_recieve.v
│   ├── shift_register_transmiter.v
│   ├── status_register.v
│   └── top.v
│
├── testbench/
│   └── tb.v
│
├── architecture/
│   └── spi_architecture.png
│
├── simulation/
│   └── waveform.png
│
└── README.md
