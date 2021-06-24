import "dart:math";

class ML {
  List matricarating = [
    [0, 0, 0, 0],
    [0, 0, 1, 0],
    [0, 0, 2, 1],
    [0, 1, 0, 0],
    [0, 1, 1, 0],
    [0, 1, 2, 1],
    [0, 2, 0, 0],
    [0, 2, 1, 1],
    [0, 2, 2, 1],
    [1, 0, 0, 0],
    [1, 0, 1, 0],
    [1, 0, 2, 1],
    [1, 1, 0, 0],
    [1, 1, 1, 1],
    [1, 1, 2, 2],
    [1, 2, 0, 1],
    [1, 2, 1, 1],
    [1, 2, 2, 2],
    [2, 0, 0, 0],
    [2, 0, 1, 1],
    [2, 0, 2, 2],
    [2, 1, 0, 1],
    [2, 1, 1, 1],
    [2, 1, 2, 2],
    [2, 2, 0, 1],
    [2, 2, 1, 2],
    [2, 2, 2, 2],
  ];

  List diapozonrat = [
    [0, 0.3, 0.2, 0.7, 0.6, 1],
    [0, 0.3, 0.2, 0.7, 0.6, 1],
    [0, 0.3, 0.2, 0.7, 0.6, 1],
  ];

  double niz(znachenie, a, b) {
    double otvet = 0;
    if (znachenie <= a) otvet = 1;
    if (znachenie >= b) otvet = 0;

    if (znachenie >= a && znachenie <= b) otvet = (b - znachenie) / (b - a);
    return otvet;
  }

  double sred(znachenie, a, c) {
    double otvet = 0;
    double b;
    b = (c + a) / 2;

    if (znachenie <= a) otvet = 0;
    if (znachenie >= c) otvet = 0;

    if (znachenie >= a && znachenie <= b) otvet = (znachenie - a) / (b - a);
    if (znachenie >= b && znachenie <= c) otvet = (c - znachenie) / (c - b);

    return otvet;
  }

  double visokiy(znachenie, a, b) {
    double otvet = 0;
    if (znachenie <= a) otvet = 0;
    if (znachenie >= b) otvet = 1;
    if (znachenie >= a && znachenie <= b) otvet = (znachenie - a) / (b - a);

    return otvet;
  }

  List BazaZnaniyRating(int nomerkriteri, List masiv) {
    double znacheniefun;
    List znacheniefuniterma = [];

    for (int i = 0; i < 27; i++) {
      switch (matricarating[i][nomerkriteri]) {
        case 0:
          {
            znacheniefun = niz(masiv[0], masiv[1], masiv[2]);
            znacheniefuniterma.add(znacheniefun);
            break;
          }

        case 1:
          {
            znacheniefun = sred(masiv[0], masiv[3], masiv[4]);
            znacheniefuniterma.add(znacheniefun);
            break;
          }

        case 2:
          {
            znacheniefun = visokiy(masiv[0], masiv[5], masiv[6]);
            znacheniefuniterma.add(znacheniefun);
            break;
          }
      }
    }

    return znacheniefuniterma;
  }

  double Rating(int maxSkidka, List znach) {
    List masivnach = List.generate(3, (index) => List(7), growable: false);
    List masivsugeno = List(27);
    List matricaznachprinad = List.generate(27, (index) => List(4), growable: false);


    double otvet = 0;

    for (int i = 0; i < 3; i++) {
      masivnach[i][0] = znach[i];
      for (int j = 1; j < 7; j++) {
        masivnach[i][j] = diapozonrat[i][j - 1];
      }
    }

    for (int i = 0; i < 3; i++) {
      List masiv = new List(7);

      for (int k = 0; k < 7; k++) {
        masiv[k] = masivnach[i][k];
      }
      for (int j = 0; j < 27; j++) {
        matricaznachprinad[j][i] = BazaZnaniyRating(i, masiv)[j];
      }
    }

    for (int i = 0; i < 27; i++) {
      matricaznachprinad[i][3] = min<double>(
          min(matricaznachprinad[i][0], matricaznachprinad[i][1]),
          matricaznachprinad[i][2]);
      masivsugeno[i] =
          (maxSkidka / 2)  * masivnach[0][0] + (maxSkidka / 4) * masivnach[1][0] + (maxSkidka / 4) * masivnach[2][0];
    }

    double summinznachmatricaznachprinad = 0;
    List masivchislit = List(27);

    for (int i = 0; i < 27; i++) {
      masivchislit[i] = matricaznachprinad[i][3] * masivsugeno[i];
      summinznachmatricaznachprinad += matricaznachprinad[i][3];
    }

    for (int i = 0; i < masivchislit.length; i++) {
      otvet += masivchislit[i];
    }

    return otvet / summinznachmatricaznachprinad;
  }

  double getKoff(int month) {
    List season = ["Зима", "Весна", "Лето", "Осень"];
    switch (season[(month / 3).floor()]) {
      case "Лето":
        {
          return 1 / 3;
          break;
        }
      case "Осень":
        {
          return 2 / 3;
          break;
        }
      case "Весна":
        {
          return 2 / 3;
          break;
        }
      case "Зима":
        {
          return 3 / 3;
          break;
        }
    }
  }

}