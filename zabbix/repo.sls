{% from "zabbix/map.jinja" import zabbix with context %}

# Zabbix official repo releases a deb package that sets a zabbix.list apt
# sources. Here we do the same as that package does, including the PGP key for
# the repo.


{%- if salt['grains.get']('os_family') == 'Debian' %}
zabbix_repo:
  pkgrepo:
    - managed
    - name: deb http://repo.zabbix.com/zabbix/{{ zabbix.version_repo }}/ubuntu {{grains['oscodename']}} main
    - file: /etc/apt/sources.list.d/zabbix.list
    - require:
      - cmd: zabbix_repo_add_gpg


zabbix_repo_add_gpg:
  cmd:
    - wait
    - name: /usr/bin/apt-key add /var/tmp/zabbix-official-repo.gpg
    - watch:
      - file: /var/tmp/zabbix-official-repo.gpg


/var/tmp/zabbix-official-repo.gpg:
  file:
    - managed
    - contents: |
        -----BEGIN PGP PUBLIC KEY BLOCK-----

        mQGiBFCNJaYRBAC4nIW8o2NyOIswb82Xn3AYSMUcNZuKB2fMtpu0WxSXIRiX2BwC
        YXx8cIEQVYtLRBL5o0JdmoNCjW6jd5fOVem3EmOcPksvzzRWonIgFHf4EI2n1KJc
        JXX/nDC+eoh5xW35mRNFN/BEJHxxiRGGbp2MCnApwgrZLhOujaCGAwavGwCgiG4D
        wKMZ4xX6Y2Gv3MSuzMIT0bcEAKYn3WohS+udp0yC3FHDj+oxfuHpklu1xuI3y6ha
        402aEFahNi3wr316ukgdPAYLbpz76ivoouTJ/U2MqbNLjAspDvlnHXXyqPM5GC6K
        jtXPqNrRMUCrwisoAhorGUg/+S5pyXwsWcJ6EKmA80pR9HO+TbsELE5bGe/oc238
        t/2oBAC3zcQ46wPvXpMCNFb+ED71qDOlnDYaaAPbjgkvnp+WN6nZFFyevjx180Kw
        qWOLnlNP6JOuFW27MP75MDPDpbAAOVENp6qnuW9dxXTN80YpPLKUxrQS8vWPnzkY
        WtUfF75pEOACFVTgXIqEgW0E6oww2HJi9zF5fS8IlFHJztNYtbQgWmFiYml4IFNJ
        QSA8cGFja2FnZXJAemFiYml4LmNvbT6IYAQTEQIAIAUCUI0lpgIbAwYLCQgHAwIE
        FQIIAwQWAgMBAh4BAheAAAoJENE9WOR56l7UhUwAmgIGZ39U6D2w2oIWDD8m7KV3
        oI06AJ9EnOxMMlxEjTkt9lEvGhEX1bEh7bkBDQRQjSWmEAQAqx+ecOzBbhqMq5hU
        l39cJ6l4aocz6EZ9mSSoF/g+HFz6WYnPAfRaYyfLmZdtF5rGBDD4ysalYG5yD59R
        Mv5tNVf/CEx+JAPMhp6JCBkGRaH+xHws4eBPGkea4rGNVP3L3rA7g+c1YXZICGRI
        OOH7CIzIZ/w6aFGsPp7xM35ogncAAwUD/3s8Nc1OLDy81DC6rGpxfEURd5pvd/j0
        D5Di0WSBEcHXp5nThDz6ro/Vr0/FVIBtT97tmBHX27yBS3PqxxNRIjZ0GSWQqdws
        Q8o3YT+RHjBugXn8CzTOvIn+2QNMA8EtGIZPpCblJv8q6MFPi9m7avQxguMqufgg
        fAk7377Rt9RqiEkEGBECAAkFAlCNJaYCGwwACgkQ0T1Y5HnqXtQx4wCfcJZINKVq
        kQIoV3KTQAIzr6IvbZoAn12XXt4GP89xHuzPDZ86YJVAgnfK
        =+200
        -----END PGP PUBLIC KEY BLOCK-----
{%- elif salt['grains.get']('os_family') == 'RedHat' and
         salt['grains.get']('osmajorrelease')[0] == '6' %}
zabbix_repo:
  pkgrepo:
    - managed
    - name: zabbix
    - humanname: Zabbix Official Repository - $basearch
    - baseurl: http://repo.zabbix.com/zabbix/2.2/rhel/6/$basearch/
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX
    - require:
      - file: /etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX

zabbix_non_supported_repo:
  pkgrepo:
    - managed
    - name: zabbix_non_supported
    - humanname: Zabbix Official Repository non-supported - $basearch
    - baseurl: http://repo.zabbix.com/non-supported/rhel/6/$basearch/
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX
    - require:
      - file: /etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX

/etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX:
  file:
    - managed
    - contents: |
        -----BEGIN PGP PUBLIC KEY BLOCK-----

        mQGiBFCNJaYRBAC4nIW8o2NyOIswb82Xn3AYSMUcNZuKB2fMtpu0WxSXIRiX2BwC
        YXx8cIEQVYtLRBL5o0JdmoNCjW6jd5fOVem3EmOcPksvzzRWonIgFHf4EI2n1KJc
        JXX/nDC+eoh5xW35mRNFN/BEJHxxiRGGbp2MCnApwgrZLhOujaCGAwavGwCgiG4D
        wKMZ4xX6Y2Gv3MSuzMIT0bcEAKYn3WohS+udp0yC3FHDj+oxfuHpklu1xuI3y6ha
        402aEFahNi3wr316ukgdPAYLbpz76ivoouTJ/U2MqbNLjAspDvlnHXXyqPM5GC6K
        jtXPqNrRMUCrwisoAhorGUg/+S5pyXwsWcJ6EKmA80pR9HO+TbsELE5bGe/oc238
        t/2oBAC3zcQ46wPvXpMCNFb+ED71qDOlnDYaaAPbjgkvnp+WN6nZFFyevjx180Kw
        qWOLnlNP6JOuFW27MP75MDPDpbAAOVENp6qnuW9dxXTN80YpPLKUxrQS8vWPnzkY
        WtUfF75pEOACFVTgXIqEgW0E6oww2HJi9zF5fS8IlFHJztNYtbQgWmFiYml4IFNJ
        QSA8cGFja2FnZXJAemFiYml4LmNvbT6IYAQTEQIAIAUCUI0lpgIbAwYLCQgHAwIE
        FQIIAwQWAgMBAh4BAheAAAoJENE9WOR56l7UhUwAmgIGZ39U6D2w2oIWDD8m7KV3
        oI06AJ9EnOxMMlxEjTkt9lEvGhEX1bEh7bkBDQRQjSWmEAQAqx+ecOzBbhqMq5hU
        l39cJ6l4aocz6EZ9mSSoF/g+HFz6WYnPAfRaYyfLmZdtF5rGBDD4ysalYG5yD59R
        Mv5tNVf/CEx+JAPMhp6JCBkGRaH+xHws4eBPGkea4rGNVP3L3rA7g+c1YXZICGRI
        OOH7CIzIZ/w6aFGsPp7xM35ogncAAwUD/3s8Nc1OLDy81DC6rGpxfEURd5pvd/j0
        D5Di0WSBEcHXp5nThDz6ro/Vr0/FVIBtT97tmBHX27yBS3PqxxNRIjZ0GSWQqdws
        Q8o3YT+RHjBugXn8CzTOvIn+2QNMA8EtGIZPpCblJv8q6MFPi9m7avQxguMqufgg
        fAk7377Rt9RqiEkEGBECAAkFAlCNJaYCGwwACgkQ0T1Y5HnqXtQx4wCfcJZINKVq
        kQIoV3KTQAIzr6IvbZoAn12XXt4GP89xHuzPDZ86YJVAgnfK
        =+200
        -----END PGP PUBLIC KEY BLOCK-----
{% else %}
zabbix_repo: {}
{% endif %}
