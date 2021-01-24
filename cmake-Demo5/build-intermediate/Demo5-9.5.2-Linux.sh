#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Demo5-9.5.2-Linux subdirectory
  --exclude-subdir  exclude the Demo5-9.5.2-Linux subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Demo5 Installer Version: 9.5.2, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
The MIT License (MIT)

Copyright (c) 2013 Joseph Pan(http://hahack.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Demo5 will be installed in:"
    echo "  \"${toplevel}/Demo5-9.5.2-Linux\""
    echo "Do you want to include the subdirectory Demo5-9.5.2-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Demo5-9.5.2-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +170 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Demo5-9.5.2-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� �9` �\}p�ߓl,[��p��e�C��8X�e����Y�ζ}8ҩ�hܸe��L����LƝ~�i�H�h'm��7	��̴)m�䋤&_5n�qZ@}{�{�[�a� ���<�w��޾��[����p�]gr�\uuu<��:�K��+k\��ꚺ�Z�UYUU[�x��vS*)�J_,��6�7_:���?'���"D���Z_��k*��_]Y�_]�D��:����y�?�mo�p�"[ѝKYn$x��9�FT���w�- 9G���-ZnSʑ�J����H�9ϹL}�i9r���d�Ϫ�j=�<��,�0\����x�,�7h� �?��Y���D��-�洜V3�����n�zw�|,oAZN���w��Ք�I����#-��}	��+'ڼ;IyF��c�r��*"��ښ�H�<���ʇ�k�kk�ɸ�J����Զ�ݸ�&0F�>/!2Nwv?T�cM��-��{֗}���Dmp$"�i��r>���8�A��%6[an�-5�"8n�������o~�7og�)��h���>u��=���U��~x���W>������dy"�]�����S�B8��Kp��2���]i�������!G�!8b��J�rT���U��#R��v��c��8E��/$��q�,?Hp:�҇�	�����E�\D:l�G��\�'�E.�j�ww�Z4��h0��}( ƥ�0���C_8��@�
~��R�G�E���
_q��	���uu�CBB�'E!����Ǆ�@o	�� m�d{ �G�1b��;�<��SI!�.ʁ�B���$U���������_�r��7�'�O��g!|�)is�Hjy8k�Kd:~�qm���Q�!��Q�S��V�/@sc�7Tx�
�R���pZ��T��
/T���)��fB�[U�q���{R��!�L2�$�L2��@�(��߾�l�ù�gO�7'DK�o�w�I)=�~��L�(��UR��0s��L&sD�9I>��I>��VI~��`�d�E.�rF.c�y�Z���-}�>_�-����ή��ܟ����
�5��X2�D�G@\��9���M�����N����7�W���M����1�[����KO��}��wl���^�$������}�_T�7Ҁ�Q��n�h�#�ԗ~G,�n8�ԹK��T.��@����F��>H�'ݠ��J8�K�N�8�.�����/��n;<�a��I��,n�s'��/v�~ݎ�"��a������D�L�&����%ӣ6���S=���+�ڄ/�"i������M0w^J�VI��;=S�|�N������;�jirt�J�p���u��8.eC�C��4u�"�{��$�Ru��bm���	07z�,J�:������轀/�a�-޳�����=s�!��7%x��?=���F7 ��r[�Ow[�cO�'}��7V.��}�E|�L=w!���hWU�Jګ==Ӟ��%�7O��u��$���Z�=|?ݳ�s�g��>����Y����7���;�$�L2�$�L2�$�L2��Gf����~a3_��{I���1!&�(���T�'��P������䍧||_���|$ܛ$��<*�������0�6�l-��[��-xA�]<��Lf���g�O ���d������i�ΙLf�!���7��,����=�qCnEa��'�x-�8ؔ��Z�%��p��� �vG������F���7T���ڽ�����E8\�7�p\֣px�wi��kw�4-��p������IZ���N�,���5�H��[�o[��߲z��X�׾��������~4o��1f���]��&;�d/m�;��6i��?v��I&�d�I&�d�I&�d�g��2��L������������!��V��[N8ݷ��I��R&.��`��a��({�Ȧ0��7C�B�K	_��D����}dt/Z��=��-[J�����yZ�'�gʿi��'#׏#�%"�{��t������'DV�D�}����	�$�ǡ�>���57o��u��bb���v��+])I�Z/�ڲ��*չ Vh�z]ܪ�7��9h�.���G-�@78�
�dV��
M��Φr+��R�͌V�����B�?j�¹������hD��7��)��_��YڊnR��k�tZ_��'Z��8�ŗ��c+ܕ�������e<{?�����不�����4s���i���a�:��9���*�g_�(�3����g_���7������V�.�fS���s�������$�^'%�˔��k����;l}?�~��a!'�g۽T³�Ϭ��}���������o���
������~|�><���'1��c|�ӏg8i���~|�G�~|��~\�K�~��%N?n����Plѯ�j���[,��(��b���Ds�~1��p�$8���#��@�㉤?�B�xt0"�B�Y�ro��$�7��D`�/���0�K��?��F�AE%I
��8T�"<9ޚ��p<�Ā�ߺ����{�����&�o%���@,�c&Z�l�t�5k��؉mۻ�^1�k�	PWG35��}G��ݿ��u�����ij���6vG�46��*p��!�r<	��Ɛ��W����Spc�0HD��B��pT�2�gPA!1����(8�c)�`">($�aԛ
GB���<Mm�b�Ii�� r��cP��ń��U!��~����"���FD���:���$)�S�@�Zי�Km�Hg%�$نܩdzE�a0&��5FN�c�е�n��!�����(���k�6��(����k}6�q-��}�lc����~��Y��p��!�>}���^���T�� �߱��-�%�ȩ���Pic�s2��=�{�D�;է�Ӕo`�g�e���w.���G��S��9*{����	�|����&"��x�{T��:�?Ds��1q��)��O0�����N&?��3F��?Pξ��O3��=���y�����ʟW�����O�;)/b���y�?���CL~���`�⑍��ѧ�K��cn��w���̃���r��6����X�O�Ϗ^��E$_{��ě�i���֣��Z9���y|�<��S�N��t8��V�R!��Q����å������Y�ώ�����難��!�f8�P�����]M�ke��1�忁��M2_�(���X0�
	��0���/Օյ��_n���c}�~���(c����V}��ڿ�]Sm~��FК� O�߽��������[�L�_&z�k�'��00���=~��]�r���_[�5��Ak�}1����;��:P�@�D��S���f����ȇc��]t����5B,�3G��E½����U��7�p�á�׶�yڿ�]]�|��]�r������w��;*x-���]�J�Ѓ�z�ZyT���*X����V�WT���������xe����c�qȑo�4�z�n$�vT��,������ҧ�^����=g�����|�^���-#$�����w�X��hE�Q	V��JY�fv(�o�go�X,s�+�F�^�S�l�n#�pw�^_��īpʹ�e���y�F��Bl�b��zm]�U��5'ɒ��s-�G3�M���^�؞������I.�[���&nC�� ���˖�i�?�~%ҟ�'�hn��&�?�x��2��)o��	�	L�G	����������?ү�4�����^���:ퟏ���hn�Ω��{z
t��V]���~�s�#D�]�	M2�$�>��_�Ѽ� `  