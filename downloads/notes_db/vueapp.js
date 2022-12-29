const dates = ['2023-01-02', '2023-01-04', '2023-01-05', '2023-01-09', '2023-01-11', '2023-01-16', '2023-01-18', '2023-01-19', '2023-01-23', '2023-01-25', '2023-02-06', '2023-02-08', '2023-02-09', '2023-02-13', '2023-02-15', '2023-02-16', '2023-02-20', '2023-02-22', '2023-02-23', '2023-02-27', '2023-03-01', '2023-03-06', '2023-03-08', '2023-03-09'].map(dt => new Date(dt));
const days = ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'];
const eleves = ['ادم المزاز', 'ادم غوفة', 'اية اللجمي', 'احمد بن موسى', 'احمد بشار القرماني', 'احمد امين بيوض', 'احمد سحيمي', 'احمد مبارك الترجمان', 'احمد ضياء ابراهيم', 'انس الرواتبي', 'ايمن ماني', 'اسراء اللجمي', 'دانية الداعي', 'ريان بوغريو', 'شهد تومية', 'عمر الخصيبي', 'عمر ابن عمر', 'فادي عبد الله', 'محمد امين الصغير', 'محمد امين قسومة', 'محمد رايد محفوظ', 'محمد ياسين بن الفقيه', 'محمد امين سهلول', 'هاشم المهيري', 'ياسمين يزيد', 'يسري البامري'];
const ident = ['013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013390038735', '013382046642', '012975060914', '013175041164', '012669030762', '013435035924', '013499034605', '013214035770', '013214022737', '013346035592', '013382046743', '013384019883', '013378024172', '013349029155', '013348045112', '013357045092', '013262034101', '013267012726', '012210037674', '013553037838', '013184044986', '012195039555', '012878006451', '013419030621', '013225016069'];
const mois = ['', 'Jan', 'Fév', 'Mars', 'Avril', 'Mai'];
const app = new Vue({
  'el': '#app',
  'data': {
    dates: dates,
    ident: ident,
    eleves: eleves,
    data: Array(eleves.length).fill('-').map(() => Array(dates.length).fill('__')),
    nomsMois: mois,
    mois: [],
  },
  mounted: function () {
    this.classifyDates();
    this.loadData();
  },
  methods: {
    classifyDates: function () {
      this.mois = this.dates.map(dt => [dt.getFullYear(), dt.getMonth() + 1]);
      this.mois = this.mois.filter((dt, idx) => this.mois.indexOf(dt) == idx);
      console.log(this.mois);
      this.mois = this.mois.map(m => {
        const jours = this.dates.filter(dt => dt.getMonth() == (m[1]-1));
        return {
          'year': m[0],
          'month': this.nomsMois[m[1]],
          'jours': jours
        };
      });
    },
    loadData: function () {
      if (window.localStorage.getItem('presence') == null) {
        this.data = Array(this.eleves.length).fill('-').map(() => Array(this.dates.length).fill('__'));
        window.localStorage.setItem('presence', JSON.stringify(this.data));
      }
      this.data = JSON.parse(window.localStorage.getItem('presence'));
    },
    getColumnClass: function (date) {
      return days[date.getDay()];
    }
  }
});