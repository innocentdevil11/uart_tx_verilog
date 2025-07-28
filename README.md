# UART Transmitter in Verilog

This project implements a UART (Universal Asynchronous Receiver/Transmitter) **transmitter module** using **Verilog HDL**. It simulates accurate bit-serial data transmission using the 8N1 protocol — 1 start bit, 8 data bits (LSB first), 1 stop bit — and includes a testbench for validation using waveform analysis in **GTKWave**.

---

## 🔧 Features

- ✅ 8-bit UART Transmission (8N1 protocol)
- ✅ Start and Stop bit generation
- ✅ Shift register-based serial output
- ✅ Works at configurable baud rates
- ✅ Easy integration with UART receivers
- ✅ Testbench for simulation and validation
- ✅ Waveform output viewable in GTKWave

---

## 📁 File Structure

uart_tx_verilog/
│
├── uart_tx.sv # Main UART Transmitter module
├── uart_tx_tb.sv # Testbench for simulating UART transmission
├── uart_tx_waveform.png # (Optional) Sample waveform screenshot from GTKWave
├── README.md # Project documentation (this file)

## 🧠 How UART 8N1 Works

The data frame transmitted by UART 8N1 format includes:

- **Start bit**: 1 bit (logic low)
- **Data bits**: 8 bits (LSB first)
- **Stop bit**: 1 bit (logic high)

For example, to transmit `0x55` (`01010101`), the sequence on the `tx` line will be:
Idle ─ 1
Start ─ 0
Data ─ 1 0 1 0 1 0 1 0 (LSB to MSB)
Stop ─ 1
Idle ─ 1

---

## 📂 Module Overview

### `uart_tx.sv`

Implements the UART transmitter logic. Key signals:

- `clk` : System clock  
- `rst` : Active-high synchronous reset  
- `tx_start` : Pulse to start transmission  
- `data_in` : 8-bit parallel input data  
- `tx` : Serial output  
- `busy` : Indicates if transmission is in progress  

### `uart_tx_tb.sv`

A testbench that:
- Instantiates the UART transmitter
- Sends a byte (e.g., `0x55`)
- Dumps waveforms into `uart_tx.vcd`

---

## ▶️ Simulation Instructions

### 🛠️ Using Icarus Verilog and GTKWave

1. **Install** Icarus Verilog and GTKWave if not already installed.

2. **Compile the Design and Testbench**


iverilog -o uart_tx.vvp uart_tx.sv uart_tx_tb.sv


3. Run the Simulation
   
vvp uart_tx.vvp


4. Open the Waveform in GTKWave


gtkwave uart_tx.vcd
```bash

You should see the serial output waveform for the transmitted byte (e.g., 0x55).


