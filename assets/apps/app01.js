const ex01 = new Vue({
  el: '#ex01',
  data: {
    answered: false,
    correctAnswer: false,
    answers: Array(6).fill(''),
    valeurs: ["12V - 50mA", "5 🍎", "18/12/2022", "100 Mbps", "Vide", "19°C"],
    options: ["donnée", "information", "je ne sais pas"]
  },
  methods: {
    verifAnswers: function () {
      setTimeout(() => {
        this.answered = this.answers.every(val => val != '');
        if (this.answered) {
          this.correctAnswer = this.answers.every(val => val == this.options[0]);
          if (this.correctAnswer) {
            alert("Très bien! Vous avez deviné!");
          } else {
            alert("Non, c'est faux!");
          }
        }
      }, 1);
    }
  }
});

function randint(a, b) {
  return Math.floor(Math.random() * (b - a + 1));
}

const americanGrades = [
  ['A+', 5.0, 5.0025],
  ['A', 4.0, 5.0],
  ['A-', 3.67, 4.0],
  ['B+', 3.33, 3.67],
  ['B', 3.0, 3.33],
  ['B-', 2.67, 3.0],
  ['C+', 2.33, 2.67],
  ['C', 2.0, 2.33],
  ['C-', 1.67, 2.0],
  ['D', 1.0, 1.67],
  ['F', 0.0, 1.0]
];

const reponsesPossibles = ['Oui', 'Non'];
const niveauxPossibles = ['Médiocre', 'Mauvais', 'Moyen', 'Bon', 'Très bon', 'Excellent'];

function gradeToLetter(grade) {
  for (let grd of americanGrades) {
    if (grade >= grd[1]) {
      return grd[0];
    }
  }
  return '';
}

const ex02 = new Vue({
  el: '#ex02',
  data: {
    americanGrades: americanGrades,
    userDate: new Date(),
    theDate: null,
    englishDate: null,
    date: new Date('2004-12-31').toISOString().substring(0, 10),
    secondes: 0,
    jours: 0,
    ageJours: 0,
    note: randint(0, 80) / 4,
    amGrade: 'A',
    belgianGrade: 0.0,
    reponsesPossibles: reponsesPossibles,
    niveauxPossibles: niveauxPossibles,
    userYesNoAnswer: reponsesPossibles[randint(0, reponsesPossibles.length - 1)],
    userLevel: niveauxPossibles[randint(0, niveauxPossibles.length - 1)]
  },
  mounted: function () {
    this.updateDate();
    this.updateNote();
  },
  methods: {
    updateDate: function () {
      const today = new Date(new Date().toISOString().substring(0, 10));
      const dt = new Date(this.date);
      const epoch = new Date(0);
      const libreOffice = new Date('1899-12-30');
      this.userDate = dt;
      this.theDate = dt.toLocaleDateString();
      this.englishDate = dt.toLocaleDateString("en-US");
      this.secondes = (dt.getTime() - epoch.getTime()) / 1000;
      this.jours = (dt.getTime() - libreOffice.getTime()) / 1000 / 3600 / 24;
      this.ageJours = (today.getTime() - dt.getTime()) / 1000 / 3600 / 24;
    },
    updateNote: function () {
      this.amGrade = gradeToLetter(this.note / 4);
      this.belgianGrade = this.note * 50;
    }
  }
});