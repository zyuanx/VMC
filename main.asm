PORT_A EQU 280H                                                         ; 8255
PORT_B EQU 282H
PORT_C EQU 283H
PORT_CTL EQU 284H

CLK_0 EQU 288H                                                          ; 8253计数器
CLK_1 EQU 28AH
CLK_2 EQU 28CH
CLK_CTL EQU 28EH

PORT_DAC EQU 290H                                                       ; DAC口地址

DATA SEGMENT                                                            ; 数据段

HZ_TAB  DW 0A2B1H,0BFC9H,0C0D6H,0A3A8H,0D3E0H,0A3B1H,0A3B0H,0A3A9H      ; 1.    可  乐  （  余  1   0  ）
        DW 0A2B2H,0D1A9H,0B1CCH,0A3A8H,0D3E0H,0A3B1H,0A3B0H,0A3A9H      ; 2.    雪  碧  （  余  1   0  ）
        DW 0A2B3H,0C2F6H,0B6AFH,0A3A8H,0D3E0H,0A3B1H,0A3B0H,0A3A9H      ; 3.    脉  动  （  余  1   0  ）
        DW 0A2B4H,0C3E6H,0B0FCH,0A3A8H,0D3E0H,0A3B1H,0A3B0H,0A3A9H      ; 4.    面  包  （  余  1   0  ）

HZ_ADR  DB 00H                                                          ; 存放显示行起始端口地址

HZ_TAB1  DW 0D1A1H,0D4F1H,0BFC9H,0C0D6H,0A1A0H,0A3B4H,0D4AAH,0A1A0H     ; 1.    可  乐
        DW 0D1A1H,0D4F1H,0D1A9H,0B1CCH,0A1A0H,0A3B3H,0D4AAH,0A1A0H         ; 2.    雪  碧
        DW 0D1A1H,0D4F1H,0C2F6H,0B6AFH,0A1A0H,0A3B2H,0D4AAH,0A1A0H         ; 3.    脉  动
        DW 0D1A1H,0D4F1H,0C3E6H,0B0FCH,0A1A0H,0A3B1H,0D4AAH,0A1A0H         ; 4.    面  包

BLANK_LINE  DW 0A1A0H,0A1A0H,0A1A0H,0A1A0H,0A1A0H,0A1A0H,0A1A0H,0A1A0H             ; 空白行
YES_NO  DW 0CAC7H,0A1A0H,0A1A0H,0B7F1H,0A1A0H,0A1A0H,0A1A0H,0A1A0H           ; 是   否

OUT_GOOD DW 0D5FDH,0D4DAH,0B3F6H,0BBF5H,0A3ACH,0C7EBH,0C9D4H,0B5C8H      ; 正在出货，请稍等
OUT_GOOD_SUCCESS DW 0B3F6H,0BBF5H,0B3C9H,0B9A6H,0A1A0H,0A1A0H,0A1A0H,0A1A0H      ; 出货成功

ADD_GOOD DW 0CAE4H,0C8EBH,0BFDAH,0C1EEH,0B2B9H,0BBF5H,0A1A0H,0A1A0H   ; 输入口令补货
ADD_GOOD_OK DW 0B2B9H,0BBF5H,0B3C9H,0B9A6H,0A1A0H,0A1A0H,0A1A0H,0A1A0H   ; 补货成功
PASS_WORD DW 0A3B1H,0A3B2H,0A3B1H,0A3B2H,0A3B1H,0A3B2H,0A1A0H,0A1A0H     ; ROOT预设密码
PASS_INPUT DW 0A1A0H,0A1A0H,0A1A0H,0A1A0H,0A1A0H,0A1A0H,0A1A0H,0A1A0H        ; 输入口令
PASS_WRONG DW 0BFDAH,0C1EEH,0B4EDH,0CEF3H,0A1A0H,0A1A0H,0A1A0H,0A1A0H         ; 口令错误

TABLE1  DB 77H,7BH,7DH,7EH,0B7H,0BBH,0BDH,0BEH                          ; 键盘扫描码
        DB 0D7H,0DBH,0DDH,0DEH,0E7H,0EBH,0EDH,0EEH
WHICH_GOOD DB 00H
PASS_COUNT DW 0000H
MONEY_COUNT DW 0000H
STRING_MONEY DW 0CAD5H,0D2E6H,0000H,0000H,0000H,0D4AAH,0A1A0H,0A1A0H;收益XXX元

QC_GOODS DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,7FH,60H,31H,29H,0FCH,00H,00H,00H,41H,12H,7AH,0B1H,04H
DB 00H,00H,00H,5DH,68H,16H,11H,74H,00H,00H,00H,5DH,0EH,66H,61H,74H
DB 00H,00H,00H,5DH,65H,0A4H,0A1H,74H,00H,00H,00H,41H,14H,25H,61H,04H
DB 00H,00H,00H,7FH,55H,55H,55H,0FCH,00H,00H,00H,00H,43H,44H,4CH,00H
DB 00H,00H,00H,03H,3CH,0ACH,7DH,54H,00H,00H,00H,54H,0A9H,4FH,92H,70H
DB 00H,00H,00H,57H,26H,4CH,0E8H,54H,00H,00H,00H,50H,1FH,88H,00H,84H
DB 00H,00H,00H,57H,0B0H,9DH,83H,0CH,00H,00H,00H,10H,0EEH,6FH,0C8H,0A8H
DB 00H,00H,00H,5DH,0D1H,04H,8FH,14H,00H,00H,00H,68H,50H,05H,0C7H,74H
DB 00H,00H,00H,2BH,0CDH,60H,0D7H,0DCH,00H,00H,00H,42H,0B6H,09H,0F9H,88H
DB 00H,00H,00H,45H,0D4H,28H,29H,14H,00H,00H,00H,3EH,0D8H,0A4H,0D5H,0A0H
DB 00H,00H,00H,23H,0B6H,00H,73H,0F0H,00H,00H,00H,56H,12H,11H,5BH,6CH
DB 00H,00H,00H,03H,0EFH,0D8H,0CDH,0CH,00H,00H,00H,08H,6FH,5AH,1EH,28H
DB 00H,00H,00H,23H,89H,52H,31H,5CH,00H,00H,00H,4AH,0D9H,0A3H,4CH,88H
DB 00H,00H,00H,59H,42H,0C6H,3EH,5CH,00H,00H,00H,58H,0BBH,0F3H,56H,74H
DB 00H,00H,00H,4FH,0C6H,64H,27H,0C0H,00H,00H,00H,00H,77H,97H,3CH,54H
DB 00H,00H,00H,7FH,2DH,0E5H,0BDH,74H,00H,00H,00H,41H,59H,70H,5CH,6CH
DB 00H,00H,00H,5DH,35H,90H,5FH,0F4H,00H,00H,00H,5DH,3FH,0EH,19H,0D0H
DB 00H,00H,00H,5DH,1BH,85H,0E8H,94H,00H,00H,00H,41H,22H,0ACH,93H,0E4H
DB 00H,00H,00H,7FH,33H,16H,15H,34H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H
DB 00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H,00H

DATA ENDS
; 代码段
CODE    SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    ; 初始化8255，方式0，A、C口输出，B口输入
    MOV DX,PORT_CTL
    MOV AL,10000010B
    OUT DX,AL
    CALL CLEAR                                                          ; LCD清除
INIT:
    CALL LCD_DISP_INIT                                                  ; 初始化物品
    JMP CHOOSE_GOODS                                                   ; 判断选择物品
l1:
    JMP l1
CLEAR   PROC
    MOV AL,01H
    MOV DX,PORT_A
    OUT DX,AL                                                           ; 设置CLEAR命令
    CALL CMD_SETUP                                                      ; 启动LCD执行命令
    RET
CLEAR   ENDP
LCD_DISP_INIT    PROC
    ; LCD初始化显示物品
    LEA BX, HZ_TAB                                                      ; 加载物品字符显示地址
    MOV BYTE PTR HZ_ADR, 80H                                            ; 第一行起始端口地址
    call STRING_SHOW
    MOV BYTE PTR HZ_ADR, 90H                                            ; 第二行起始端口地址
    call STRING_SHOW
    MOV BYTE PTR HZ_ADR, 88H                                            ; 第三行起始端口地址
    call STRING_SHOW
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call STRING_SHOW
    RET
LCD_DISP_INIT   ENDP
DRAW_IMG PROC
    ;画二维码子程序
    MOV DX,PORT_A
    MOV AL,34H
    OUT DX,AL
    CALL CMD_SETUP
    LEA BX,QC_GOODS
    ;上半部分
    MOV CL,0
LOOP1:
    MOV CH,0
LOOP2:
    MOV AL,80H
    ADD AL,CL
    MOV DX,PORT_A
    OUT DX,AL
    CALL CMD_SETUP

    MOV AL,80H
    ADD AL,4
    ADD AL,CH
    MOV DX,PORT_A
    OUT DX,AL
    CALL CMD_SETUP

    MOV AL,[BX]
    MOV DX,PORT_A
    OUT DX,AL
    CALL DATA_SETUP
    INC BX

    MOV AL,[BX]
    MOV DX,PORT_A
    OUT DX,AL
    CALL DATA_SETUP
    INC BX

    INC CH
    CMP CH,4
    JNZ LOOP2
    
    INC CL
    CMP CL,32
    JNZ LOOP1



    
    
    ;下半部分
    MOV CL,0
LOOP5:
    MOV CH,0
LOOP6:
    MOV AL,80H
    ADD AL,CL
    MOV DX,PORT_A
    OUT DX,AL
    CALL CMD_SETUP

    MOV AL,88H
    ADD AL,4
    ADD AL,CH
    MOV DX,PORT_A
    OUT DX,AL
    CALL CMD_SETUP

    MOV AL,[BX]
    MOV DX,PORT_A
    OUT DX,AL
    CALL DATA_SETUP
    INC BX

    MOV AL,[BX]
    MOV DX,PORT_A
    OUT DX,AL
    CALL DATA_SETUP
    INC BX

    INC CH
    CMP CH,4
    JNZ LOOP6
    
    INC CL
    CMP CL,32
    JNZ LOOP5
    
    ;CALL MOTOR
    MOV DX,PORT_A
    MOV AL,36H
    OUT DX,AL
    CALL CMD_SETUP

    MOV DX,PORT_A
    MOV AL,30H
    OUT DX,AL
    CALL CMD_SETUP
    RET
DRAW_IMG ENDP
BLANK PROC
    LEA BX, BLANK_LINE
    MOV BYTE PTR HZ_ADR, 80H
    call  STRING_SHOW
    LEA BX, BLANK_LINE
    MOV BYTE PTR HZ_ADR, 90H                                            ; 第二行起始端口地址
    call  STRING_SHOW
    LEA BX, BLANK_LINE
    MOV BYTE PTR HZ_ADR, 88H                                            ; 第三行起始端口地址
    call  STRING_SHOW
    LEA BX, BLANK_LINE                                                        ; 指向是否确认信息
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call  STRING_SHOW
    RET
BLANK ENDP
BLANK2 PROC
    LEA BX, BLANK_LINE
    MOV BYTE PTR HZ_ADR, 80H
    call  STRING_SHOW_4
    LEA BX, BLANK_LINE
    MOV BYTE PTR HZ_ADR, 90H                                            ; 第二行起始端口地址
    call  STRING_SHOW_4
    LEA BX, BLANK_LINE
    MOV BYTE PTR HZ_ADR, 88H                                            ; 第三行起始端口地址
    call  STRING_SHOW_4
    LEA BX, BLANK_LINE                                                        ; 指向是否确认信息
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call  STRING_SHOW_4
    RET

BLANK2 ENDP
LCD_DISP_CHECK    PROC
    CALL CLEAR
    CALL DRAW_IMG
    ;CALL BLANK2
    ; 显示选择物品，等待确认
    LEA BX, HZ_TAB1
    MOV BYTE PTR HZ_ADR, 80H                                            ; 第一行起始端口地址
    CMP WHICH_GOOD, 1
    jz G1_SHOW
    CMP WHICH_GOOD, 2
    jz G2_SHOW
    CMP WHICH_GOOD, 3
    jz G3_SHOW
    CMP WHICH_GOOD, 4
    jz G4_SHOW

G1_SHOW:
    add bx,0                                                            ; 显示物品1
    jmp SHOW_NEXT
G2_SHOW:
    add bx,16                                                           ; 显示物品2
    jmp SHOW_NEXT
G3_SHOW:
    add bx,32                                                           ; 显示物品3
    jmp SHOW_NEXT
G4_SHOW:
    add bx,48                                                           ; 显示物品4
    jmp SHOW_NEXT
SHOW_NEXT:
    call  STRING_SHOW_4
    MOV BYTE PTR HZ_ADR, 90H                                            ; 第二行起始端口地址
    call  STRING_SHOW_4
    LEA BX, BLANK_LINE
    MOV BYTE PTR HZ_ADR, 88H                                            ; 第三行起始端口地址
    call  STRING_SHOW_4
    LEA BX, YES_NO                                                        ; 指向是否确认信息
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call  STRING_SHOW_4
    RET
LCD_DISP_CHECK ENDP

LCD_DISP_WAITING    PROC
    CALL CLEAR
    ; 等待出货
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 80H                                            ; 第一行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 90H                                            ; 第二行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 88H                                            ; 第三行起始端口地址
    call  STRING_SHOW
    LEA BX, OUT_GOOD
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call  STRING_SHOW
    CALL MOTOR                                                          ; 电机转动
                                                                        ; 出货成功
    LEA BX,OUT_GOOD_SUCCESS
    MOV BYTE PTR HZ_ADR, 80H                                            ; 第一行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 90H                                            ; 第二行起始端口地址
    call  STRING_SHOW
    sub bx,16
    MOV BYTE PTR HZ_ADR, 88H                                            ; 第三行起始端口地址
    call  STRING_SHOW
    sub bx,16
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call  STRING_SHOW
    CALL DELAY_1S
    call GOODS_DEC
    call LCD_DISP_INIT
    RET
LCD_DISP_WAITING ENDP
GOODS_DEC PROC
    ;收益相应增加
    LEA BX,MONEY_COUNT
    MOV CX,[BX]
    ;相应货物减一
    
    CMP WHICH_GOOD, 1
    jz G1_DEC
    CMP WHICH_GOOD, 2
    jz G2_DEC
    CMP WHICH_GOOD, 3
    jz G3_DEC
    CMP WHICH_GOOD, 4
    jz G4_DEC
G1_DEC:
    LEA BX, HZ_TAB1
    add bx,0
    MOV AX,[BX+10]
    SUB AX,0A3B0H
    ADD CX,AX
    MOV MONEY_COUNT,CX
    LEA BX, HZ_TAB
    add bx,0                                                            ; 显示物品1
    jmp JUDEG_GOOD
G2_DEC:
    LEA BX, HZ_TAB1
    add bx,16
    MOV AX,[BX+10]
    SUB AX,0A3B0H
    ADD CX,AX
    MOV MONEY_COUNT,CX
    LEA BX, HZ_TAB
    add bx,16                                                           ; 显示物品2
    jmp JUDEG_GOOD
G3_DEC:
    LEA BX, HZ_TAB1
    add bx,32
    MOV AX,[BX+10]
    SUB AX,0A3B0H
    ADD CX,AX
    MOV MONEY_COUNT,CX
    LEA BX, HZ_TAB
    add bx,32                                                           ; 显示物品3
    jmp JUDEG_GOOD
G4_DEC:
    LEA BX, HZ_TAB1
    add bx,48
    MOV AX,[BX+10]
    SUB AX,0A3B0H
    ADD CX,AX
    LEA BX, HZ_TAB
    add bx,48                                                           ; 显示物品4
    jmp JUDEG_GOOD

JUDEG_GOOD:                                                             ; 判断剩余量
    add bx,10
    mov ax,[bx]
    test ax,0001H                                                       ; 判断十位是否为1，为1不跳转
    jnz SW
    add bx,2
    dec [bx]
    ret
SW:
    dec [bx]
    add bx,2
    add [bx],9
    ret
GOODS_DEC ENDP
MOTOR PROC
    ; 产生0.5ms一周期的时钟
    MOV AL,00110111B                                                    ; 通道0，先低后高，方式3，BCD计数
    MOV DX,CLK_CTL
    OUT DX,AL
    MOV DX,CLK_0
    MOV AL,00H
    OUT DX,AL
    MOV AL,10H
    OUT DX,AL
    ; OUT0接CLK1
    MOV AL,01110001B                                                    ; 通道1，先低后高，方式0，BCD计数
    MOV DX,CLK_CTL
    OUT DX,AL
    MOV DX,CLK_1
    MOV AL,00H
    OUT DX,AL
    MOV AL,20H
    OUT DX,AL

    MOV AL,0FFH                                                         ; 高电平电机工作
    MOV DX,PORT_DAC
    OUT DX,AL
HEIGHT:
    MOV DX,PORT_B
    IN AL,DX                                                            ; B口输入OUT1，检测高电平
    TEST AL,20H
    JZ HEIGHT                                                           ; 为高电平，计数结束，不跳转， 检测出上升沿，延时结束

    MOV AL,00H                                                          ; 电机停止
    MOV DX,PORT_DAC
    OUT DX,AL
    ret
MOTOR ENDP
DELAY_1S PROC
    ;延时1s子程序
    ;产生0.5ms一周期的时钟
    MOV AL,00110111B                                                    ; 通道0，先低后高，方式3，BCD计数
    MOV DX,CLK_CTL
    OUT DX,AL
    MOV DX,CLK_0
    MOV AL,00H
    OUT DX,AL
    MOV AL,10H
    OUT DX,AL
    ; OUT0接CLK1
    MOV AL,01110001B                                                    ; 通道1，先低后高，方式0，BCD计数
    MOV DX,CLK_CTL
    OUT DX,AL
    MOV DX,CLK_1
    MOV AL,00H
    OUT DX,AL
    MOV AL,20H
    OUT DX,AL

HEIGHT1:
    MOV DX,PORT_B
    IN AL,DX                                                            ; B口输入OUT1，检测高电平
    TEST AL,20H
    JZ HEIGHT1                                                          ; 为高电平，计数结束，不跳转， 检测出上升沿，延时结束
    ret
DELAY_1S ENDP

STRING_SHOW_4 PROC
    mov cl,4
CONTINUE:
    push cx
    mov al,HZ_ADR
    MOV DX, PORT_A
    OUT DX, AL
    CALL CMD_SETUP                                                      ; 设定DDRAM地址命令
    MOV AX,[BX]
    PUSH AX
    MOV AL,AH                                                           ; 先送汉字编码高位
    MOV DX,PORT_A
    OUT DX,AL
    CALL DATA_SETUP                                                     ; 输出汉字编码高字节
    POP AX
    MOV DX,PORT_A
    OUT DX, AL
    CALL DATA_SETUP                                                     ; 输出汉字编码低字节
    INC BX
    INC BX                                                              ; 修改显示内码缓冲区指针
    INC BYTE PTR HZ_ADR                                                 ; 修改LCD显示端口地址
    POP CX
    DEC CL
    JNZ  CONTINUE
    RET
STRING_SHOW_4 ENDP

STRING_SHOW PROC
    mov cl,8
CONTINUE1:
    push cx
    mov al,HZ_ADR
    MOV DX, PORT_A
    OUT DX, AL
    CALL CMD_SETUP                                                      ; 设定DDRAM地址命令
    MOV AX,[BX]
    PUSH AX
    MOV AL,AH                                                           ; 先送汉字编码高位
    MOV DX,PORT_A
    OUT DX,AL
    CALL DATA_SETUP                                                     ; 输出汉字编码高字节
    POP AX
    MOV DX,PORT_A
    OUT DX, AL
    CALL DATA_SETUP                                                     ; 输出汉字编码低字节
    INC BX
    INC BX                                                              ; 修改显示内码缓冲区指针
    INC BYTE PTR HZ_ADR                                                 ; 修改LCD显示端口地址
    POP CX
    DEC CL
    JNZ  CONTINUE1
    RET
STRING_SHOW ENDP

CMD_SETUP       PROC
    MOV DX,PORT_C                                                       ; 指向8255端口控制端口
    NOP
    MOV AL,00000000B                                                    ; PC1置0,pc0置0 （LCD I端=0，W端＝0）
    OUT DX, AL
    NOP
    MOV AL,00000100B                                                    ; PC2置1 （LCD E端＝1）
    OUT DX, AL
    NOP
    MOV AL, 00000000B                                                   ; PC2置0,（LCD E端置0）
    OUT DX, AL
    RET
CMD_SETUP       ENDP

DATA_SETUP    PROC
    MOV DX,PORT_C                                                       ; 指向8255控制端口
    MOV AL,00000001B                                                    ; PC1置0，PC0=1 （LCD I端=1）
    OUT DX, AL
    NOP
    MOV AL,00000101B                                                    ; PC2置1 （LCD E端＝1）
    OUT DX, AL
    NOP
    MOV AL, 00000001B                                                   ; PC2置0,（LCD E端＝0）
    OUT DX, AL
    NOP
    RET
DATA_SETUP      ENDP

CHOOSE_GOODS PROC
;选择物品子程序
;向所有行送0
S:  MOV DX,PORT_C
    MOV AL,00H
    OUT DX,AL
    ; 查看所有键是否松开
    MOV DX,PORT_B
WAIT_OPEN:
    IN AL,DX
    AND AL,0FH
    CMP AL,0FH
    JNE WAIT_OPEN
    ; 各键均松开，查列是否有0
WAIT_PRES:
    IN AL,DX
    AND AL,0FH                                                          ; 只查低四位
    CMP AL,0FH
    JE WAIT_PRES
    ; 延时20ms，消抖动
    MOV CX,16EAH
DELAY1:LOOP DELAY1                                                      ; CX为0，跳出循环
    IN AL,DX                                                            ; 再查列，看按键是否仍被压着
    AND AL,0FH
    CMP AL,0FH
    JE WAIT_PRES
    ; 键仍被按下，确定哪一个键被按下
    MOV AL,0FEH
    MOV CL,AL
NEXT_ROW:MOV DX,PORT_C
    OUT DX,AL                                                           ; 向一行输出低电平
    MOV DX,PORT_B
    IN AL,DX                                                            ; 读入B口状态
    AND AL,0FH                                                          ; 只检测低四位，即列值
    CMP AL,0FH                                                          ; 是否均为1，若是，则此行无按键按下
    JNE ENCODE                                                          ; 否，此行有按键按下，转去编码
    ROL CL,1                                                            ; 均为1，转去下行
    MOV AL,CL
    JMP NEXT_ROW                                                        ; 查看下一行
ENCODE:MOV BX,000FH
    IN AL,DX
NEXT_TRY:CMP AL,TABLE1[BX]                                              ; 读入的行列值是否与表中的值相等
    JE DONE                                                             ; 相等，跳至数码管显示
    DEC BX
    JNS NEXT_TRY                                                        ; 非负，继续检查
    MOV AH,01
    JMP EXIT
DONE:
    mov cl,1
    cmp bx,01H                                                          ; 选择1号商品
    JZ G1
    cmp bx,02H                                                          ; 选择2号商品
    JZ G2
    cmp bx,03H                                                          ; 选择3号商品
    JZ G3
    cmp bx,04H                                                          ; 选择4号商品
    JZ G4
    cmp bx,0EH                                                          ; 确认选择商品
    JZ G5
    cmp bx,0FH                                                          ; 取消选择商品
    JZ temp1
    cmp bx,0CH                                                          ; 选择补货商品
    JZ temp2
    cmp bx,0DH                                                          ; 选择查看收益
    JZ temp3
temp1:
    CALL CLEAR
    jmp INIT
temp2:
    jmp LCD_DISP_ADD
temp3:
    jmp MONEY_SHOW
G1:
    MOV CH,1                                                            ; 显示1号商品信息
    mov BYTE PTR WHICH_GOOD,ch
    CALL LCD_DISP_CHECK
    jmp s
G2:
    MOV CH,2                                                            ; 显示2号商品信息
    mov BYTE PTR WHICH_GOOD,ch
    CALL LCD_DISP_CHECK
    jmp s
G3:
    MOV CH,3                                                            ; 显示3号商品信息
    mov BYTE PTR WHICH_GOOD,ch
    CALL LCD_DISP_CHECK
    jmp s
G4:
    MOV CH,4                                                            ; 显示4号商品信息
    mov BYTE PTR WHICH_GOOD,ch
    CALL LCD_DISP_CHECK
    jmp s
G5:
    
    call LCD_DISP_WAITING
    jmp s

CHOOSE_GOODS ENDP
ADD_GOOD_KEY PROC
; 向所有行送0
S1:  MOV DX,PORT_C
    MOV AL,00H
    OUT DX,AL
    ; 查看所有键是否松开
    MOV DX,PORT_B
WAIT_OPEN1:
    IN AL,DX
    AND AL,0FH
    CMP AL,0FH
    JNE WAIT_OPEN1
    ; 各键均松开，查列是否有0
WAIT_PRES1:
    IN AL,DX
    AND AL,0FH                                                          ; 只查低四位
    CMP AL,0FH
    JE WAIT_PRES1
    ; 延时20ms，消抖动
    MOV CX,16EAH
DELAY2:LOOP DELAY2                                                      ; CX为0，跳出循环
    IN AL,DX                                                            ; 再查列，看按键是否仍被压着
    AND AL,0FH
    CMP AL,0FH
    JE WAIT_PRES1
    ; 键仍被按下，确定哪一个键被按下
    MOV AL,0FEH
    MOV CL,AL
NEXT_ROW1:MOV DX,PORT_C
    OUT DX,AL                                                           ; 向一行输出低电平
    MOV DX,PORT_B
    IN AL,DX                                                            ; 读入B口状态
    AND AL,0FH                                                          ; 只检测低四位，即列值
    CMP AL,0FH                                                          ; 是否均为1，若是，则此行无按键按下
    JNE ENCODE1                                                         ; 否，此行有按键按下，转去编码
    ROL CL,1                                                            ; 均为1，转去下行
    MOV AL,CL
    JMP NEXT_ROW1                                                        ; 查看下一行
ENCODE1:MOV BX,000FH
    IN AL,DX
NEXT_TRY1:CMP AL,TABLE1[BX]                                              ; 读入的行列值是否与表中的值相等
    JE DONE1                                                             ; 相等，跳至数码管显示
    DEC BX
    JNS NEXT_TRY1                                                        ; 非负，继续检查
    MOV AH,01
    JMP EXIT
DONE1:
    mov ax,bx
    LEA BX, PASS_COUNT
    mov cx,[bx]
    inc [bx]
    LEA BX, PASS_INPUT
    add cx,cx
    add bx,cx
    add ax,0A3B0H
    mov [bx],ax
    LEA BX, PASS_INPUT
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call  STRING_SHOW
    LEA BX, PASS_COUNT
    cmp [bx],4
    jz ADD_OK
    jmp s1
ADD_OK:
    mov cx,0
PASS_WHILE:
    LEA BX, PASS_INPUT
    add bx,cx
    mov ax,[bx]
    LEA BX, PASS_WORD
    add bx,cx
    cmp cx,8
    jz PASS_TRUE
    add cx,2
    cmp [bx],ax
    jz PASS_WHILE
    mov cx,0
pass_re:
    LEA BX, PASS_INPUT
    add bx,cx
    mov [bx],0A1A0H
    add cx,2
    cmp cx,8
    jnz pass_re
    LEA BX, PASS_COUNT
    mov [bx],0000h
    LEA BX, PASS_WRONG
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call  STRING_SHOW
    CALL DELAY_1S
    JMP INIT
PASS_TRUE:
    ;显示补货成功
    LEA BX, ADD_GOOD_OK
    MOV BYTE PTR HZ_ADR, 80H                                            ; 第一行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 90H                                            ; 第二行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 88H                                            ; 第三行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call  STRING_SHOW
    call DELAY_1S
    ; LCD初始化显示物品
    LEA BX, HZ_TAB
    mov [bx+10],0A3B1H
    mov [bx+12],0A3B0H
    add bx,16
    mov [bx+10],0A3B1H
    mov [bx+12],0A3B0H
    add bx,16
    mov [bx+10],0A3B1H
    mov [bx+12],0A3B0H
    add bx,16
    mov [bx+10],0A3B1H
    mov [bx+12],0A3B0H
pass_re1:
    LEA BX, PASS_INPUT
    add bx,cx
    mov [bx],0A1A0H
    add cx,2
    cmp cx,8
    jnz pass_re1
    LEA BX, PASS_COUNT
    mov [bx],0000h

    JMP INIT
    ret
ADD_GOOD_KEY ENDP
LCD_DISP_ADD PROC
;显示输入的口令
    LEA BX, ADD_GOOD
    MOV BYTE PTR HZ_ADR, 80H                                            ; 第一行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 90H                                            ; 第二行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 88H                                            ; 第三行起始端口地址
    call  STRING_SHOW
    LEA BX,PASS_INPUT
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call  STRING_SHOW
    jmp ADD_GOOD_KEY
    RET
LCD_DISP_ADD ENDP
MONEY_SHOW PROC
;显示收益
    CALL CAL_MONEY
    LEA BX,STRING_MONEY
    MOV BYTE PTR HZ_ADR, 80H                                            ; 第一行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 90H                                            ; 第二行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 88H                                            ; 第三行起始端口地址
    call  STRING_SHOW
    LEA BX,BLANK_LINE
    MOV BYTE PTR HZ_ADR, 98H                                            ; 第四行起始端口地址
    call  STRING_SHOW
    CALL DELAY_1S
    jmp INIT
MONEY_SHOW ENDP
CAL_MONEY PROC
;判断收益，修改lcd显示，最高三位
    ;百位
    LEA BX,MONEY_COUNT
    MOV AX,[BX]
    MOV BL,64H
    DIV BL;商在AL，余数在AH
    LEA BX,STRING_MONEY
    ADD BX,4
    MOV CX,0A3B0H
    ADD CL,AL
    MOV [BX],CX
    ;十位
    MOV AL,AH
    MOV AH,00H
    MOV BL,0AH
    DIV BL
    LEA BX,STRING_MONEY
    ADD BX,6
    MOV CX,0A3B0H
    ADD CL,AL
    MOV [BX],CX
    ;个位
    LEA BX,STRING_MONEY
    ADD BX,8
    MOV CH,0A3H
    MOV CL,0B0H
    ADD CL,AH
    MOV [BX],CX
    RET
CAL_MONEY ENDP
EXIT:HLT
CODE    ENDS
        END START
