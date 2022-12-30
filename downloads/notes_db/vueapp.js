const dates = ['2023-01-02', '2023-01-04', '2023-01-05', '2023-01-09', '2023-01-11', '2023-01-16', '2023-01-18', '2023-01-19', '2023-01-23', '2023-01-25', '2023-02-06', '2023-02-08', '2023-02-09', '2023-02-13', '2023-02-15', '2023-02-20', '2023-02-22', '2023-02-23', '2023-02-27', '2023-03-01', '2023-03-06', '2023-03-08', '2023-03-09'].map(dt => new Date(dt));
const days = ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'];
const eleves = ['ادم المزاز', 'ادم غوفة', 'اية اللجمي', 'احمد بن موسى', 'احمد بشار القرماني', 'احمد امين بيوض', 'احمد سحيمي', 'احمد مبارك الترجمان', 'احمد ضياء ابراهيم', 'انس الرواتبي', 'ايمن ماني', 'اسراء اللجمي', 'دانية الداعي', 'ريان بوغريو', 'شهد تومية', 'عمر الخصيبي', 'عمر ابن عمر', 'فادي عبد الله', 'محمد امين الصغير', 'محمد امين قسومة', 'محمد رايد محفوظ', 'محمد ياسين بن الفقيه', 'محمد امين سهلول', 'هاشم المهيري', 'ياسمين يزيد', 'يسري البامري'];
const ident = ['013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013365017179', '013390038735', '013382046642', '012975060914', '013175041164', '012669030762', '013435035924', '013499034605', '013214035770', '013214022737', '013346035592', '013382046743', '013384019883', '013378024172', '013349029155', '013348045112', '013357045092', '013262034101', '013267012726', '012210037674', '013553037838', '013184044986', '012195039555', '012878006451', '013419030621', '013225016069'];
const mois = ['', 'Jan', 'Fév', 'Mars', 'Avril', 'Mai', 'Jui', 'Jul', 'Août', 'Sept', 'Oct', 'Nov', 'Déc'];
function download(filename, text) {
  var element = document.createElement('a');
  element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
  element.setAttribute('download', filename);
  element.style.display = 'none';
  document.body.appendChild(element);
  element.click();
  document.body.removeChild(element);
}
const app = new Vue({
  'el': '#app',
  'data': {
    mode: 'menu',
    dates: dates,
    ident: ident,
    eleves: eleves,
    data: Array(eleves.length).fill('-').map(() => Array(dates.length).fill('')),
    nomsMois: mois,
    days: days,
    selectedDate: -1,
    todayDate: new Date(new Date().toISOString().substring(0, 10)),
    uploadDataText: '',
    mois: [],
    tempData: [],
    elevesSummary: [],
    selectedField: {
      idxName: -1,
      idxDate: -1
    }
  },
  mounted: function () {
    this.classifyDates();
    this.loadData();
  },
  methods: {
    classifyDates: function () {
      this.mois = this.dates.map(dt => {
        return {
          'year': dt.getFullYear(),
          'month': dt.getMonth() + 1
        }
      });
      this.mois = this.mois.filter((dt, idx) => this.mois.findIndex(dt1 => dt.year == dt1.year && dt.month == dt1.month) == idx);
      this.mois = this.mois.map(m => {
        const jours = this.dates.filter(dt => dt.getMonth() == (m.month - 1));
        const alldays = [];
        let emptyDays = 0;
        for (let i = 1; i <= 31; i++) {
          const dt = new Date(m.year + '-' + ((m.month < 10) ? '0' : '') + m.month + '-' + ((i < 10) ? '0' : '') + i);
          if (i == 1) {
            emptyDays = dt.getDay();
          }
          if (dt.getMonth() != (m.month - 1)) break;
          alldays.push(dt);
        }
        return {
          'allDays': alldays,
          'emptyDays': emptyDays,
          'year': m.year,
          'month': m.month,
          'monthName': this.nomsMois[m.month],
          'jours': jours
        };
      });
    },
    loadData: function () {
      if (window.localStorage.getItem('presence') == null) {
        this.data = Array(this.eleves.length).fill('-').map(() => Array(this.dates.length).fill('UCC'));
        this.saveData();
      }
      this.data = JSON.parse(window.localStorage.getItem('presence'));
    },
    saveData: function () {
      window.localStorage.setItem('presence', JSON.stringify(this.data));
    },
    getColumnClass: function (date) {
      return days[date.getDay()];
    },
    getHighlightedDateIndex: function (date) {
      return this.dates.findIndex(dt => dt.getTime() == date.getTime());
    },
    selectDate: function (date) {
      const idxDate = this.getHighlightedDateIndex(date);
      this.tempData = this.eleves.map((eleve, idxName) => {
        let arr = this.data[idxName][idxDate].split('');
        if (arr.length != 3 || (arr[0] != 'P' && arr[0] != 'N')) {
          arr = ['U', 'C', 'C'];
        }
        return arr;
      });
      this.selectedDate = idxDate;
    },
    beginChanging: function (idxName) {
      this.selectedField.idxName = idxName;
      this.selectedField.content = this.tempData[idxName];
      this.$forceUpdate();
      this.$nextTick(() => {
        const ctrl = document.getElementById("data" + idxName);
        ctrl.focus();
        ctrl.select();
      });
    },
    keyup: function (e) {
      if (e.key == 'Enter') {
        this.endChanging();
      } else if (e.key == 'Escape') {
        this.tempData[this.selectedField.idxName] = this.selectedField.content;
        this.endChanging();
      }
    },
    endChanging: function () {
      this.selectedField.idxName = -1;
      this.$forceUpdate();
    },
    saveChanges: function () {
      this.eleves.forEach((el, idxName) => {
        if (this.tempData[idxName][0] == 'U') {
          this.tempData[idxName][1] = 'C';
          this.tempData[idxName][2] = 'C';
        }
        if (this.tempData[idxName][0] == 'N') {
          this.tempData[idxName][2] = 'C';
        }
        this.data[idxName][this.selectedDate] = this.tempData[idxName].join('');
      });
      this.saveData();
      this.cancelChanges();
    },
    cancelChanges: function () {
      this.selectedField.idxName = -1;
      this.selectedDate = -1;
    },
    setMode: function (mode) {
      this.mode = mode;
      if (mode == 'download') {
        this.uploadDataText = JSON.stringify(this.data);
      } else if (mode == 'upload') {
        this.uploadDataText = '';
      } else if (mode == 'summary') {
        this.prepareSummary();
      }
    },
    downloadData: function () {
      const regex = /[TZ\.]/gi;
      let filename = new Date().toISOString()
        .replaceAll(':', '-')
        .replaceAll(regex, '_');
      download(filename, JSON.stringify(this.data));
      this.setMode('menu');
    },
    uploadData: function () {
      let error = this.uploadDataText == '';
      let tmpData;
      if (!error) {
        try {
          tmpData = JSON.parse(this.uploadDataText);
          if (Array.isArray(tmpData) && tmpData.length != this.eleves.length) {
            error = true;
          }
          if (!error) {
            error = !tmpData.every(item => Array.isArray(item) && item.length == this.dates.length);
          }
        }
        catch (err) {
          error = true;
        }
      }
      if (error) {
        alert("لا يمكن توريد المعطيات.");
        return;
      }
      this.data = tmpData;
      this.saveData();
      this.setMode('menu');
    },
    prepareSummary: function () {
      const ABC = 'ABC';
      this.elevesSummary = this.eleves.map((el, idxName) => {
        const p = this.data[idxName].reduce((pv, cv) => pv + (cv.indexOf('P') != -1), 0);
        const j = this.data[idxName].reduce((pv, cv) => {
          if (cv.length >= 2 && ABC.indexOf(cv[1]) != -1) {
            pv[cv[1]]++;
          }
          return pv;
        }, { 'A': 0, 'B': 0, 'C': 0 });
        const p1 = this.data[idxName].reduce((pv, cv) => {
          if (cv.length >= 3 && ABC.indexOf(cv[2]) != -1) {
            pv[cv[2]]++;
          }
          return pv;
        }, { 'A': 0, 'B': 0, 'C': 0 });
        return {
          total: this.dates.length,
          presence: p,
          jour: j,
          precedent: p1
        }
      });
    }
  }
});