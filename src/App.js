import React, { useState } from 'react';

function App() {
  // 1. Durum (State) Tanımlamaları
  const [oyunAdi, setOyunAdi] = useState("");
  const [tur, setTur] = useState("RPG"); 
  const [puan, setPuan] = useState("5"); // Sayı yerine direkt string tutalım, kafamız karışmasın
  const [oyunListesi, setOyunListesi] = useState([]);

  // 2. Ekleme İşlemi
  const oyunEkle = () => {
    if (oyunAdi !== "") {
      const yeniOyun = { ad: oyunAdi, tur: tur, puan: puan };
      setOyunListesi([...oyunListesi, yeniOyun]);
      
      // Kutuları temizle
      setOyunAdi(""); 
    }
  };

  // 3. Silme İşlemi
  const oyunSil = (index) => {
    const yeniListe = oyunListesi.filter((_, i) => i !== index);
    setOyunListesi(yeniListe);
  };

  // 4. Güncelleme İşlemi
  const oyunGuncelle = (index) => {
    const yeniIsim = prompt("Yeni oyun adını yazınız:");
    
    if (yeniIsim !== null && yeniIsim !== "") {
      const yeniListe = [...oyunListesi];
      yeniListe[index].ad = yeniIsim;
      setOyunListesi(yeniListe);
    }
  };

  return (
    <div className="bg-dark text-light min-vh-100 py-5">
      <div className="container">
        
        {/* Başlık Bölümü */}
        <header className="pb-3 mb-5 border-bottom border-secondary">
          <h1 className="display-5 fw-bold text-info">🎮 Benim Oyun Arşivi</h1>
        </header>

        {/* Oyun Ekleme Formu */}
        <div className="p-4 mb-5 bg-secondary text-white rounded shadow-sm">
          <h3 className="mb-3">Yeni Oyun Kaydet</h3>
          <div className="row g-3">
            
            <div className="col-md-4">
              <label className="form-label">Oyun Adı</label>
              <input 
                type="text" 
                className="form-control" 
                placeholder="Oyunun adını giriniz..." 
                value={oyunAdi}
                onChange={(e) => setOyunAdi(e.target.value)} 
              />
            </div>

            <div className="col-md-3">
              <label className="form-label">Oyun Türü</label>
              <select className="form-select" value={tur} onChange={(e) => setTur(e.target.value)}>
                <option value="RPG">RPG</option>
                <option value="Simulation">Simulation</option>
                <option value="Action">Action</option>
                <option value="Strategy">Strategy</option>
                <option value="Survival">Survival</option>
              </select>
            </div>

            <div className="col-md-3">
              <label className="form-label">Puanı (0 - 10): {puan}</label>
              <input 
                type="range" 
                className="form-range" 
                min="0" 
                max="10" 
                value={puan} 
                onChange={(e) => setPuan(e.target.value)}
              />
            </div>

            <div className="col-md-2 d-flex align-items-end">
              <button className="btn btn-info w-100 fw-bold" onClick={oyunEkle}>
                EKLE
              </button>
            </div>

          </div>
        </div>

        {/* Oyunları Listeleme Alanı */}
        <div className="row">
          <h3 className="mb-3">Koleksiyondaki Oyunlar ({oyunListesi.length})</h3>
          
          {oyunListesi.map((oyun, index) => (
            <div className="col-md-4 mb-3" key={index}>
              <div className="card bg-secondary text-white h-100 shadow-sm">
                <div className="card-body">
                  <div className="d-flex justify-content-between align-items-center mb-2">
                    <h5 className="card-title text-info mb-0">{oyun.ad}</h5>
                    <span className="badge bg-dark">{oyun.tur}</span>
                  </div>
                  <p className="card-text">⭐ Puan: {oyun.puan}/10</p>
                  <div className="d-flex justify-content-end gap-2 mt-3">
                    <button className="btn btn-warning btn-sm" onClick={() => oyunGuncelle(index)}>Düzenle</button>
                    <button className="btn btn-danger btn-sm" onClick={() => oyunSil(index)}>Sil</button>
                  </div>
                </div>
              </div>
            </div>
          ))}

          {/* Liste Boşsa Çıkacak Yazı */}
          {oyunListesi.length === 0 && (
            <p className="text-muted italic ps-3">Henüz bir oyun eklemediniz.</p>
          )}
        </div>

      </div>
    </div>
  );
}

export default App;