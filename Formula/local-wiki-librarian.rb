class LocalWikiLibrarian < Formula
  include Language::Python::Virtualenv

  desc "Fail-closed, authority-aware retrieval for local Markdown knowledge bases"
  homepage "https://github.com/JeremyDev87/librarian"
  url "https://github.com/JeremyDev87/librarian/releases/download/v0.1.0/local_wiki_librarian-0.1.0.tar.gz"
  sha256 "b57763ad9ecc3811b477b081bd55b7e4d7213f84cbc0dc4a6291a100f1b78d51"
  license "Apache-2.0"

  depends_on "libyaml"
  depends_on "python@3.13"

  resource "cython" do
    url "https://files.pythonhosted.org/packages/f6/de/db48b8870e766cfea809986cc50c1e986c663a9ab7bafd0ac1a2512c4a26/cython-3.2.9.tar.gz"
    sha256 "d249c9022ab13286b17bd66f30609e800c5f95efeecb06168990c7a66cecde6c"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/6d/44/f5da03a8ef95d369145c5bb53050e7877c9f3d312e128605fd9504829143/setuptools-84.0.0.tar.gz"
    sha256 "f4695c21257f0d9b537ec2692c941d02ee143b7cc1276941349a546573b2ef73"
  end

  def install
    ENV["PIP_NO_INDEX"] = "1"
    venv = virtualenv_create(libexec, "python3.13")
    venv.pip_install resource("setuptools"), build_isolation: false
    venv.pip_install resource("cython"), build_isolation: false
    venv.pip_install resource("pyyaml"), build_isolation: false
    venv.pip_install_and_link buildpath, build_isolation: false
  end

  test do
    wiki_root = testpath/"wiki"
    state_root = testpath/"state"
    wiki_root.mkpath
    (wiki_root/"current.md").write <<~MARKDOWN
      ---
      authority: high
      status: active
      ---
      # Current truth

      Homebrew functional test marker.
    MARKDOWN

    system bin/"wiki-librarian-refresh", "--wiki-root", wiki_root,
           "--state-root", state_root
    health = JSON.parse(shell_output("#{bin}/wiki-librarian health --state-root #{state_root}"))
    assert_equal "ok", health.fetch("status")
    assert_equal "librarian", health.fetch("mode")
  end
end
