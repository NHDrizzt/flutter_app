class Anime {
  var IDAnime;
  String NomeAnime;
  String Estudio;
  String Duracao;
  String Imagem;
  String Categoria;
// List<Temporada> Temporadas { get; set; }
  String Descricao;
  var QtdEpsTotal;

  Anime(
      String NomeAnime,
      String Estudio,
      String Duracao,
      String Categoria,
      String Descricao,
      ){
    this.NomeAnime = NomeAnime;
    this.Estudio = Estudio;
    this.Duracao = Duracao;
    this.Imagem = Imagem;
    this.Categoria = Categoria;
    this.Descricao = Descricao;
    this.QtdEpsTotal = QtdEpsTotal;
  }

}
//String NomeAnime,
//    String Estudio,
//String Duracao,
//    String Categoria,
//String Descricao,
//var QtdEpsTotal,