package br.integration.cookemasterapi;

import br.integration.cookmasterapi.model.Usuario;
import br.integration.cookmasterapi.services.CategoriaService;
import br.integration.cookmasterapi.services.UsuarioService;
import org.junit.jupiter.api.*;

public class    UsuarioTest {



    private Usuario usuario = new Usuario();
    private static long id;
    private static String nome;
    private static String email;


    @BeforeAll
    static void beforeAll() {
        id = 0;
        nome = "";
        email ="";
    }

    @BeforeEach
    void setUp() {
        id = 1;
        nome = "testName";
        email = "aaa@email.com";
        usuario.setId(id);
        usuario.setNome(nome);
        usuario.setEmail(email);
    }


    @Test
    @DisplayName("Teste para a criação de usuário")
    void testCreateUsuario() {
        UsuarioService usuarioService = new UsuarioService();
        Assertions.assertThrows(Exception.class, () -> {
            usuarioService.validaInsert(usuario);
        }, "Não deve informar o ID para inserir o ususario");
    }

    @Test
    @DisplayName("Teste para a atualização de usuário")
    void testUpdateUsuario() {
        UsuarioService usuarioService = new UsuarioService();
        usuario.setNome("primeiro usuario");
        Assertions.assertThrows(Exception.class, () -> {
            usuarioService.validaInsert(usuario);
        }, "ususario com o mesmo nome já inserido");
    }


}
