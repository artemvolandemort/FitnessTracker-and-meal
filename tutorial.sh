if ! command -v _build/old/pylonsd &> /dev/null
then
    mkdir -p _build/old
    wget -c "https://github.com/Pylons-tech/pylons/archive/refs/tags/v${OLD_VERSION}.zip" -O _build/v${OLD_VERSION}.zip
    unzip _build/v${OLD_VERSION}.zip -d _build
    cd ./_build/pylons-${OLD_VERSION}
    GOBIN="$ROOT/_build/old" go install -mod=readonly ./...
    cd ../..
fi

if [ $WILL_RECOVER -eq 0 ];
then
    KEY_INFO=$(pylonsd keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO)
    echo $KEY_INFO >> debug/keys.txt
else
    KEY_INFO=$(pylonsd keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO --recover)
    echo $KEY_INFO >> debug/keys.txt
fi

echo >&1 "\n"
