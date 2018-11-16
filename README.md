# timer
8 bit counter Timer 

Features:

- 8 bit counter
- Interruption generation
- Trigger generation
- PWM generation
- Input pulses counter
- External clock
- Prescaler

Module registers:


- 0x1	CTRL_IN	Control input
- 0x2	CTRL_OUT	Control output
- 0x4	STATUS	Timer status 
- 0x8	CNT_INIT	Timer initialization
- 0x9	CNT_MIN	Counter min 
- 0xA	CNT_MAX	Counter max 
- 0xB	CNT	Actual counter value
- 0xC	CNT_M1	Counter match value 0
- 0xD	CNT_M2	Counter match value 1
