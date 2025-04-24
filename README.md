Entendido! Aqui está o **README.md** completo, com as instruções de uso e as listas de ferramentas e configurações que o script irá instalar e configurar. Todo o conteúdo estará dentro do próprio arquivo **README.md**.

```markdown
# ArchDotfiles

Este repositório contém minha configuração personalizada para sistemas Arch Linux e derivados. Ao executar o script `install.sh`, você configurará seu ambiente de desenvolvimento com as ferramentas e configurações descritas abaixo.

## 🚀 Como usar

1. **Clone o repositório:**

   Clone este repositório para o diretório desejado:

   ```bash
   git clone https://github.com/Rodrigo160731/ArchDotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Execute o script de instalação:**

   O script `install.sh` instalará e configurará automaticamente as ferramentas e configurações.

   ```bash
   ./install.sh
   ```

   Este script irá:
   - Instalar o **Neovim** com **AstroVim**.
   - Configurar o **Zsh** com **Powerlevel10k**.
   - Configurar o **tmux**.
   - Instalar ferramentas essenciais para o terminal e desenvolvimento.

3. **Reinicie o terminal ou faça logout/login** para aplicar as mudanças.

---

## 🧰 **Ferramentas Instaladas e Configurações**

Durante a execução do script, as seguintes ferramentas e configurações serão instaladas e configuradas automaticamente:

### **Ferramentas Instaladas**
- **Neovim** (com configuração do AstroVim)
- **Zsh** (com Powerlevel10k)
- **tmux** (com plugins úteis)
- **htop**: Monitor de recursos do sistema.
- **btop**: Alternativa ao htop com uma interface mais moderna.
- **exa**: Substituto moderno do ls com suporte a ícones.
- **bat**: Substituto do cat com destaque de sintaxe.
- **fzf**: Ferramenta interativa de busca de arquivos e conteúdo.
- **ranger**: Gerenciador de arquivos no terminal.
- **jq**: Ferramenta para manipulação de JSON.
- **ripgrep**: Ferramenta de busca rápida.
- **zsh-autosuggestions**: Sugestões automáticas no Zsh.
- **zsh-syntax-highlighting**: Destaque de sintaxe no Zsh.
- **git**: Sistema de controle de versão.
- **curl**: Ferramenta para transferir dados de ou para um servidor.

### **Configurações Feitas**

- **Zsh**: Configurado como o shell padrão, com o **Powerlevel10k** como tema e plugins como `zsh-autosuggestions` e `zsh-syntax-highlighting`.
- **Neovim**: Instalação do **AstroVim** com configuração personalizada, incluindo:
  - **nvim-treesitter**: Realce de sintaxe avançado.
  - **lspconfig**: Suporte a servidores LSP (Language Server Protocol).
  - **telescope.nvim**: Para buscar e navegar por arquivos.
  - **nvim-autopairs**: Para completar automaticamente parênteses, chaves e outros símbolos.
  - **nerd-fonts**: Ícones de fontes para Neovim.
- **tmux**: Configuração do **tmux** com atalhos, estilização e plugins úteis, como:
  - **tmux-resurrect**: Para salvar e restaurar sessões de tmux.
  - **tmux-continuum**: Para auto-salvamento de sessões.
  - **tpm**: Tmux Plugin Manager, para gerenciar os plugins de tmux facilmente.

---

## 📦 **Outras Configurações do Sistema**

### **Pacman**
O script utiliza o **Pacman**, o gerenciador de pacotes padrão do Arch Linux, para instalar as ferramentas necessárias.

### **Fontes**
As fontes do **Powerlevel10k** e **Nerd Fonts** são instaladas automaticamente, para garantir que os ícones e a aparência do terminal funcionem corretamente.

### **Arch Linux & Derivados**
Este setup foi desenvolvido para sistemas baseados no Arch Linux e seus derivados (como Manjaro, EndeavourOS, etc.). O script foi projetado para facilitar a instalação e configuração dessas ferramentas, tornando a experiência do terminal mais eficiente e agradável.

---

## 🛠️ **Personalizações Específicas**

- **Alias de Comandos**: São adicionados aliases úteis para facilitar o uso de comandos comuns no terminal, como:
  - `ls` → `exa`
  - `cat` → `bat`
  - `grep` → `ripgrep`
  - `df` → `htop`
  
- **.zshrc**: A configuração do **Zsh** inclui configurações de prompt, aliases e plugins para melhorar a produtividade.

- **.tmux.conf**: Personalização do **tmux** com suporte a múltiplas janelas e painéis, além dos plugins mencionados acima.

---

## 📝 **Notas Finais**

- O **script `install.sh`** requer permissões de execução. Se necessário, execute `chmod +x install.sh` para garantir que ele possa ser executado.
- Este repositório contém minhas preferências pessoais de configurações. Sinta-se à vontade para adaptar conforme necessário para o seu uso.
- Se você encontrar algum problema, por favor, abra uma **issue** ou contribua com um **pull request**.

---

### Licença

Este projeto está licenciado sob a MIT License - consulte o arquivo [LICENSE](LICENSE) para mais detalhes.

```

---

Este README fornece todas as informações necessárias sobre como usar o repositório, o que será instalado e as configurações feitas, de forma simples e direta. Agora, ao rodar o script `install.sh`, o usuário terá uma ideia clara do que está sendo configurado no sistema.

Se precisar de mais alguma alteração ou adicionar detalhes, é só avisar!
