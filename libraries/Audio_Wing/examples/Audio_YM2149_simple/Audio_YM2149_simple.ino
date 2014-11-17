/*
 Gadget Factory
 YM2149 Audio Player Example
 To learn more about the Papilio Schematic Library please visit http://learn.gadgetfactory.net
 
 Hardware:
  Connect an Audio Wing to the CH WingSlot

 created 2012
 by Jack Gassett
 http://www.gadgetfactory.net
 
 This example code is in the public domain.
 */
#define circuit Audio_Wing

 #define FREQ 17000          //Freq for ymplayer
 
#include <SD.h>
#include <SPI.h>
#include "YM2149.h"
#include "SmallFS.h"
#include "ymplayer.h"
#include "ramFS.h"
#include "cbuffer.h"

YMPLAYER ymplayer;
YM2149 ym2149;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
   //Start SmallFS
  if (SmallFS.begin()<0) {
	//Serial.println("No SmalLFS found.");
  }
  else{
     //Serial.println("SmallFS Started.");
  }  

  //Set what wishbone slot the ym2149 device is connected to.  
  ymplayer.setup(&ym2149,6); 
  
  ym2149.V1.setVolume(11);
  ym2149.V2.setVolume(11);
  ym2149.V3.setVolume(11);   

  ymplayer.loadFile("music.ymd");
  ymplayer.play(true);
  
 //Setup timer for YM and mod players, this generates an interrupt at 17Khz
  TMR0CTL = 0;
  TMR0CNT = 0;
  TMR0CMP = ((CLK_FREQ/2) / FREQ )- 1;
  TMR0CTL = _BV(TCTLENA)|_BV(TCTLCCM)|_BV(TCTLDIR)|
  	_BV(TCTLCP0) | _BV(TCTLIEN);
  INTRMASK = BIT(INTRLINE_TIMER0); // Enable Timer0 interrupt
  INTRCTL=1;    

}

void _zpu_interrupt()
{
  //Interrupt runs at 17KHz
  ymplayer.zpu_interrupt(); 
}

void loop() {
  // put your main code here, to run repeatedly: 
  if (ymplayer.getPlaying() == 1)
    ymplayer.audiofill();
}
