(function() {
  var app = angular.module('storybubbles', [ ]);

  app.controller('ThemeController', function(){
    this.themes = themes;
    console.log('hi');
  });

  var themes = [
    {
      name: 'Space',
      price: 2,
      description: 'Space stories...but really just Tom the chipmunk in the forest',
      available: true,
      canPurchase: true
    },
    {
      name: 'Forest',
      price: 5.95,
      description: 'Lol no stories here',
      available: true,
      canPurchase: false
    },
    {
      name: 'Desert',
      price: 9.99,
      description: "Seriously don't bother opening this",
      available: false,
      canPurchase: false
    },
  ]
})();
