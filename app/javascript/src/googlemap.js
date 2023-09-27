var geocoder;
var marker = [];
var infoWindow = [];
var spot = gon.post; // postsコントローラーから現在表示されている投稿のデータを格納
var spots = gon.posts; // postsコントローラーからスポットのデータを格納
var spots_location = []; // スポットの場所を格納する配列
var spots_lat = []; // スポットの緯度を格納する配列
var spots_lng = []; // スポットの経度を格納する配列
var currentLocationMarker; // 現在地のマーカー

// GoogleMapを表示
function initMap() {
  console.log(hoge)
  geocoder = new google.maps.Geocoder();



  // ビューのid='map_index'にGoogleMapを埋め込み
  map = new google.maps.Map(document.getElementById('map_index'), {
    center: {
      lat: spot.latitude,
      lng: spot.longitude
    },
    zoom: 9,
  });

  // スポットの数分繰り返し処理を行いマップ上表示
  for (var i = 0; i < spots.length; i++) {
    markerLatLng = new google.maps.LatLng({
      lat: spots[i]['latitude'],
      lng: spots[i]['longitude']
    });

    // マーカーの表示
    marker[i] = new google.maps.Marker({
      position: markerLatLng,
      map: map
    });

    // 吹き出しの表示
    let id = spots[i]['id'];
    spots_location[i] = spots[i]['location'];
    spots_lat[i] = spots[i]['latitude'];
    spots_lng[i] = spots[i]['longitude'];
    infoWindow[i] = new google.maps.InfoWindow({
      // 吹き出しの中身を設定し、ボタンを追加
      content: `<a href='/posts/${id}'>${spots[i]['location']}</a><input type="button" value="追加" onclick="addPost(spots_location, spots_lat, spots_lng, ${i})">`
    });

    markerEvent(i);
  }
}

// マーカーをクリック時情報ウィンドウを表示
function markerEvent(i) {
  marker[i].addListener('click', function () {
    infoWindow[i].open(map, marker[i]);
  });
}

// 現在地を取得しマーカーを追加、ボタンにクリックイベントを追加
var currentLocationButton = document.getElementById('current-location-button');
currentLocationButton.addEventListener('click', getCurrentLocationAndAddMarker);

var customMarkerIcon = {
  fillColor: 'red', // 塗りつぶしの色を赤に設定
  fillOpacity: 1, // 塗りつぶしの不透明度を設定
  scale: 10, // マーカーアイコンのサイズを設定
};


// 現在地を取得しマーカーを追加
function getCurrentLocationAndAddMarker() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function (position) {
      var currentLatLng = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      if (currentLocationMarker) {
        // 現在地マーカーがすでに存在する場合削除する
        currentLocationMarker.setMap(null);
      }
      currentLocationMarker = new google.maps.Marker({
        position: currentLatLng,
        map: map,
        title: "現在地"
      });

      // マーカーをクリック時、情報ウィンドウを表示
      currentLocationMarker.addListener('click', function () {
        var contentString = "現在の位置";
        contentString += `<input type="button" value="追加" onclick="addPost(['現在置'], [${currentLatLng.lat}], [${currentLatLng.lng}], -1)">`;

        infoWindow[infoWindow.length] = new google.maps.InfoWindow({
          content: contentString
        });
        infoWindow[infoWindow.length - 1].open(map, currentLocationMarker);
      });

      map.setCenter(currentLatLng);
    });
  } else {
    alert("このブラウザでは位置情報が利用できません");
  }
}

// 検索リストにスポットを追加
function addPost(location, lat, lng, number) {
  // <li>要素作成
  var li = document.createElement('li');

  if (number === -1) {
    // 現在地情報の場合
    li.textContent = location;
  } else {
    li.textContent = location[number];
  }

  li.className = "list-group-item";

  if (number === -1) {
    // 現在地情報の場合
    li.setAttribute("data-lat", lat);
    li.setAttribute("data-lng", lng);
  } else {
    // スポットの場合
    li.setAttribute("data-lat", lat[number]);
    li.setAttribute("data-lng", lng[number]);
  }

  // id が route-list の要素の末尾に <li> 要素を追加
  var routeList = document.getElementById('route-list');
  routeList.appendChild(li);
}

// ドロップダウンメニューで移動方法を選択できる
var travelModeSelector = document.getElementById('travel-mode-selector');

// ルートを検索
function search() {

  var points = $('#route-list li');

  // 2つ以上の地点が選択された場合
  if (points.length >= 2) {
    var origin;
    var destination;
    var waypoints = [];

    for (var i = 0; i < points.length; i++) {
      points[i] = new google.maps.LatLng($(points[i]).attr("data-lat"), $(points[i]).attr("data-lng"));
      if (i == 0) {
        origin = points[i];
      } else if (i == points.length - 1) {
        destination = points[i];
      } else {
        waypoints.push({
          location: points[i],
          stopover: true
        });
      }
    }

    // 選択された移動方法を取得
    var selectedTravelMode = travelModeSelector.value;

    // ルート検索のリクエストを作成
    var request = {
      origin: origin,
      destination: destination,
      waypoints: waypoints,
      travelMode: google.maps.TravelMode[selectedTravelMode], // 選択された移動方法を指定
    };

    // ルートサービスのリクエスト
    new google.maps.DirectionsService().route(request, function (response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        new google.maps.DirectionsRenderer({
          map: map,
          suppressMarkers: true,
          panel: document.getElementById('directions-panel'),
          polylineOptions: {
            strokeColor: '#00ffdd',
            strokeOpacity: 1,
            strokeWeight: 5
          }
        }).setDirections(response);
      } else {
        alert('ルートを見つけることができませんでした: ' + status);
      }
    });
  } else {
    alert('2つ以上の地点を追加してください。');
  }
}