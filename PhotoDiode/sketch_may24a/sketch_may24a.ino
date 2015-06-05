int Photodiode=A0;unsigned char datH;unsigned char datL;int dat;int ind=0;
// 1 for measurement ; 2 for query identity
void setup(){
  pinMode(Photodiode,INPUT);
  Serial.begin(57600);
}

void loop(){
  if( ind=Serial.read()){
    if( ind == 0){
      dat=analogRead(Photodiode);
      datH=dat/256;datL=dat%256;
      Serial.write(datH);Serial.write(datL);
    }
    if(ind == 1){
      Serial.write(170);Serial.write(170);// 1010 1010 Send back 32768 as the identity
    }  
  }
}
