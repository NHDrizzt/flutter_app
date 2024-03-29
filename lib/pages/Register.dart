import 'package:flutter/material.dart';
import 'package:flutter_app/DAO/UsuarioDAO.dart';
import 'package:flutter_app/Model/colors.dart';
import 'package:line_icons/line_icons.dart';

TextEditingController _nameCtrl = new TextEditingController();
TextEditingController _passwordCtrl = new TextEditingController();
TextEditingController _nicknameCtrl = new TextEditingController();
TextEditingController _emailCtrl = new TextEditingController();

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

final GlobalKey<FormState> _formkeyReg = GlobalKey<FormState>();

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  int _genderRadioBtnVal = -1;

  void _handleGenderChange(int value) {
    setState(() {
      _genderRadioBtnVal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _reg() async {
      final formState = _formkeyReg.currentState;
      //Valida se todos os campos do Form não retornaram erro
      if (formState.validate()) {
        formState.save();
        if (await FirebaseUs().create(_emailCtrl.text, _passwordCtrl.text) !=
            null) {
          _showDialog(context, "Email cadastrado! ",
              " Cadastrado com sucesso! ^u^", true);
        } else {
          _showDialog(context, "Email já cadastrado",
              "Esta conta de email já está cadastrada, seu chupinga", false);
        }
      }
    }

    final appBar = Padding(
      padding: EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )
        ],
      ),
    );

    final pageTitle = Container(
      child: Text(
        "Cadastre-se :)",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 40.0,
        ),
      ),
    );

    final formFieldSpacing = SizedBox(
      height: 30.0,
    );

    final registerForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formkeyReg,
        child: Column(
          children: <Widget>[
            _buildFormField('Nome', LineIcons.user, _nameCtrl),
            formFieldSpacing,
            _buildFormField('Nickname', LineIcons.user_plus, _nicknameCtrl),
            formFieldSpacing,
            _buildFormField('Email ', LineIcons.envelope, _emailCtrl),
            formFieldSpacing,
            _buildFormField('Senha', LineIcons.lock, _passwordCtrl),
            formFieldSpacing,
          ],
        ),
      ),
    );

    final gender = Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Row(
        children: <Widget>[
          Radio(
            value: 0,
            groupValue: _genderRadioBtnVal,
            onChanged: _handleGenderChange,
          ),
          Text("Masculino"),
          Radio(
            value: 1,
            groupValue: _genderRadioBtnVal,
            onChanged: _handleGenderChange,
          ),
          Text("Feminino"),
          Radio(
            value: 2,
            groupValue: _genderRadioBtnVal,
            onChanged: _handleGenderChange,
          ),
          Text("Outro"),
        ],
      ),
    );

    final submitBtn = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: Colors.white),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(7.0),
          color: primaryColor,
          elevation: 10.0,
          shadowColor: Colors.white70,
          child: MaterialButton(
            onPressed: _reg,
            child: Text(
              'Criar Conta',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              appBar,
              Container(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    pageTitle,
                    registerForm,
                    gender,
                    submitBtn
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(
      String label, IconData icon, TextEditingController ctr) {
    return TextFormField(
      controller: ctr,
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor, digite a(o) $label! ';
        }
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          icon,
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  }
}

_showDialog(
    BuildContext context, String titulo, String conteudo, bool success) {
  final _dig = AlertDialog(
      title: new Text(titulo),
      content: new Text(conteudo),
      actions: <Widget>[
        // define os botões na base do dialogo
        new FlatButton(
          child: new Text("Fechar"),
          onPressed: () {
            if (success) {
              Navigator.popAndPushNamed(context, '/Library');
            } else {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              _nameCtrl.clear();
              _nicknameCtrl.clear();
              _passwordCtrl.clear();
              _emailCtrl.clear();
            }
          },
        ),
      ]);

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return _dig;
      });
}
