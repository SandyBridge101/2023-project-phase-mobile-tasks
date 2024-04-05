

class Logic{
  int increment(int number){
    number=(number+1)%11;

    return number;
  }

  int decrement(int number){
    number=(number-1)%11;
    return number;
  }
}