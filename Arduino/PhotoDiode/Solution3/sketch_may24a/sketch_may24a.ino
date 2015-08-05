// 2015 08 05 ADXL335 is added to this programm
int Photodiode=A0;unsigned char datH[3500];unsigned char datL[3500];int DatNum=0; int dat;int ind=0;int i;
int ADXL_X = A5; int ADXL_Y = A6; int X_Dat;int Y_Dat;
// 1 for measurement ; 2 for query identity
void setup(){
  pinMode(Photodiode,INPUT);
  Serial.begin(57600);
  analogReference(EXTERNAL);
}

void loop(){
  if( ind ==1 ){
    Serial.write(170);Serial.write(170);  // Indicate that I am the arduino board 
    ind=0;
  }
  if( ind == 2 ){
    dat =  analogRead(Photodiode);          // To perform measurement
    datH[0]=dat/256;datL[0]=dat%256;
    Serial.write(datH[0]);Serial.write(datL[0]); 
    ind = 0;  // To prevent looping
  }
  if( ind == 4 ){
    dat =  analogRead(Photodiode);          // To perform measurement
    //delayMicroseconds(40960);                 // Delay is microsecond
    delay(10);                              // Delay is millisecond here 10ms
    DatNum = DatNum +1;
    datH[DatNum]=dat/256;datL[DatNum]=dat%256;                         
  }  

  if( ind == 3 ){
    int i;
 //   Serial.write(DatNum);            // Tell PC the number of data you have picked
    for( i=1;i<=DatNum;i++){                        //Send back the data obtained
        Serial.write(datH[i]);Serial.write(datL[i]);
    }
    ind=0;DatNum=0;
  }
  if( ind == 5 ){ // To get current angle 
    X_Dat = analogRead( ADXL_X );
    Serial.write(X_Dat/256);Serial.write(X_Dat%256);
    Y_Dat = analogRead( ADXL_Y );
    Serial.write(Y_Dat/256);Serial.write(Y_Dat%256);
    ind = 0;
  }  
}
void serialEvent(){
  ind = Serial.read();
  if( ind == 2 )DatNum=0;
}
