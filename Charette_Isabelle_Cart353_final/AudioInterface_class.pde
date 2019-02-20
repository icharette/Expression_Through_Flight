//intermediate class to access sound data easily
class AudioInterface {

  //sum of the frequencies scaled according to their amplitude
  float SumscaledFreq = 0;

  //sum of amplitudes
  float sumAmplitude = 0;

  //constructor
  AudioInterface() {
  }

  //returns average freqency at the moment the computer takes a sound sample
  float averageFreq() {


    //for every sample (half of them because of convention in FFT)...
    for (int i = 0; i < numberOfSamples/2; i++) {

      //...find frequency
      float rawFreq = fft.indexToFreq(i); 
      // println("raw freq___" + rawFreq);

      //...fin amplitude
      float amplitude = fft.getBand(i);

      //add all the scaled frequencies(when multiplied with assigned amplitude)
      SumscaledFreq = SumscaledFreq + rawFreq*amplitude;

      //add all amplitudes
      sumAmplitude = sumAmplitude + amplitude;
    }
  

    //calculate weighted average of frequency at the moment the sample was taken
    float  temp = SumscaledFreq/sumAmplitude;

    return temp;
  }

  //returns volume
  float getVolume() {

    //calculate average amplitude of all frequencies recorded
    float temp = fft.calcAvg(0, 44100);

    return temp;
  }
}