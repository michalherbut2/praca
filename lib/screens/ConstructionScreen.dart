import 'package:flutter/material.dart';
import 'package:most_app/widgets/StaffMemberCard.dart';
import 'package:most_app/widgets/UpcomingEventsWidget.dart';
import 'package:most_app/widgets/AnnouncementWidget.dart';
import 'package:most_app/widgets/TodayEventsWidget.dart';

import '../widgets/SectionHeader.dart';

class ConstructionScreen extends StatelessWidget {
  const ConstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),

          const SectionHeader(text: 'Sekstet'),
          StaffMemberCard(name: 'ks. Mateusz Buczek', title: "Duszpastrz", imagePath: "assets/photos/Meżczyzna-awatar.jpg", description: "Jestem salezjaninem od 2015 roku, a od 2023 księdzem. Urodziłem się i wychowałem na Dolnym Śląsku. Księdza Bosko i salezjanów znam od dzieciństwa i muszę przyznać, że uważam to za wielki dar w moim życiu. Interesuję się duchowością i psychologią. W Moście pełnię rolę duszpasterza i jestem do Twojej dyspozycji jeśli chodzi o rozmowę, spowiedź i to w czym będę w stanie Ci pomóc. Również pełnię funkcję delegata ds. duszpasterstwa powołaniowego... jeśli chcesz porozmawiać o swoim powołaniu lub chcesz żebym pomodlił się w intencji rozeznania – jestem w gotowości."),

          StaffMemberCard(name: 's. Natalia Roman', title: "Duszpastrz", imagePath: "assets/photos/s.-Natalia-Roman-600x600.jpg", description: "Jestem salezjanką, miłośniczką (Ż)życia i człowieka. Od dziecka zakochaną we Wspomożycielce, ks. Bosko, Poznańskiej Piątce i Tolkienie ✨. Moimi pasjami są historia, literatura, muzyka klasyczna i balet, wysokie góry i rolki. Nie przestaję marzyć i kocham wschody słońca. Ulubione słowo – „czułość”.\nI najważniejsze – JESTEM tu dla Ciebie! 💙!"),

          StaffMemberCard(name: 'ks. Dawid Nowak SDB', title: "Duszpastrz", imagePath: "assets/photos/xD-600x600.jpg", description: "Wychowałem się w stolicy polskiego rocka. Choć salezjanów poznałem w pociągu relacji: Ostrów Wlkp. – Poznań. Wtedy moja wielka przygoda z Bogiem i ks. Bosko się rozpoczęła i trwa już ponad 20 lat. To jest naprawdę Przygoda Życia. W moich oczach mam nieustannie włącząną funkcję: dobry kadr! Jestem biernym sportowcem :)"),

          StaffMemberCard(name: 'Marek Łykowski', title: "Szef", imagePath: "assets/photos/Marek-MostowiakLykowski-600x600.jpg", description: "Cześć. Studiuję dziennikarstwo i komunikację społeczną na UWr. W Moście na pewno spotkamy się na scholi albo przy zmywaniu naczyń. Wcześniej zajmowałem się przęsłem medialnym."),

          StaffMemberCard(name: 'Karolina Szklińska', title: "Wiceszef", imagePath: "assets/photos/Karolina-Szklinska-600x600.jpg", description: "Cześć, jestem Karolina i studiuję Gospodarkę Przestrzenną. W wolnym czasie lubię słuchać muzyki, spędzać aktywnie czas, podróżować oraz brać udział w harcerskiej przygodzie! Do Mostu trafiłam poprzez trzy różne sposoby, a zostałam dzięki wydarzeniom i ludziom, których tu poznałam. Wcześniej zajmowałam się przęsłem gospodarczym."),

          StaffMemberCard(name: 'Jan Switana', title: "Wiceszef", imagePath: "assets/photos/Jan-Switana-600x600.jpg", description: "Cześć! Jestem Janek i studiuję mechatronikę na PWr. Bardzo lubię konstruować🦿, budować🦾, ulepszać⚙️ i …formować⚱️ różne rzeczy. W ostatnim czasie zgłębiam też tematykę samorozwoju, a w szczególności formowania dobrych nawyków.\nCzy kolejny raz wspomnialem o formowaniu? Właśnie, bo w Moście będę odpowiedzialny za przęsło formacyjne, w którym dbamy o to, czego wszyscy potrzebujemy dla naszego rozwoju jako młodych ludzi. Stąd bardzo serdecznie zapraszam Was do MOSTu w poniedziałki i wtorki wieczorem, gdyż są to dni, w których odbywają się wydarzenia naszego przęsła: Lectio Divina, KKo, Reflektor oraz MKF.\Jeżeli macie jakieś pytania lub sprawy, to śmiało możecie do mnie podbijać. Chętnie was poznam, spróbuję pomóc i odpowiedzieć na pytania.\nDo zobaczenia!"),

          const SectionHeader(text: 'Przęsłowi'),
          StaffMemberCard(name: 'Hanna Dziki', title: "Przęsło duchowe", imagePath: "assets/photos/Hania-Dziki-600x600.jpg", description: "Ks. Jan Bosko zaprasza nas do nieustannej pracy nad sobą i troski o rozwój duchowy. Trwając wiernie na modlitwie, wzbogacając serce na adoracjach i ucząc się życia we wspólnocie, odkrywamy, jak żyć w duchu salezjańskim i kroczyć drogą świętości.\nWarto walczyć o swoją duszę, otwierać się na Boże działanie i służyć innym z miłością. Otwórz swoje serce na Boga i dla Boga!\nSerdecznie zapraszamy na spotkania Przęsła Duchowego – szczególnie w środy. Czekamy na Ciebie!”"),

          StaffMemberCard(name: 'Janek Chudzik', title: "Przęsło liturgiczne", imagePath: "assets/photos/Janek-ChudzikQuke-600x600.jpg", description: "Nasze przęsło zajmuje się wszystkim tym, co z liturgią związane. Czuwamy nad jej prawidłowym zorganizowaniem i przebiegiem. Zachęcamy wszystkich do posługiwania w trakcie Mszy lub nabożeństw. Chcemy pomóc wszystkim uczestniczącym w liturgii jeszcze lepiej ją przeżywać i poznawać. Dlatego też bardzo zapraszamy Cię do naszego przęsła. Szczegóły znajdziesz w konkretnych podprzęsłach."),

          StaffMemberCard(name: 'Jakub Staniszewski', title: "Przęsło formacyjne", imagePath: "assets/photos/Jakub-Staniszewski-600x600.jpg", description: """Ważnym elementem życia każdego z nas jest formacja, czyli ciągłe doskonalenie naszych postaw i świadomości, rozwój wiary oraz wszelkie działania pomagające nam zbliżyć się do Boga i innych ludzi oraz być lepszym i szczęśliwszym człowiekiem. W Moście rozwój ten wspierany jest przez przęsło formacyjne, w ramach którego odbywają się wydarzenia takie jak:

          • Lectio divina – Podczas cotygodniowych spotkań czytamy i rozważamy Ewangelię z najbliższej niedzieli. Jest to czas pytań, odpowiedzi i przede wszystkim refleksji nad Słowem Bożym, a także na podzielenie się z innymi tym, jak Słowo Boże na nas wpłynęło. Każde spotkanie pozwala na pogłębienie wiedzy o Piśmie Świętym oraz symbolach, które są w nim zawarte. Na spotkania zapraszamy w poniedziałki o godzinie 20:00 po akademickiej Mszy Świętej.

          • KKo… – na tych spotkaniach będziemy zgłębiać nauczanie Kościoła słuchając konferencji opiertych na katechizmie, dokumentach Kościoła i nauczaniu papieży. Wierzymy bowiem, że wiara rodzi się ze słuchania. Również, jako rodzina salezjańska poprzez te spotkania realizujemy dwa filary naszej duchowości: rozum oraz religia.

          • Reflektor – spotkania dyskusyjne. Podejmujemy na nich tematy, które nas, studentów, młodych ludzi nurtują: polityka, światopogląd, zdrowie, duchowość, nauka.

          • MKF, czyli Mostowy Klub Filmowy – Tu oglądamy wspólnie dobry film, by później podzielić się wrażeniami i podyskutować o tym, jakie przemyślenia zrodziły się w nas po seansie.

          • Boska Husaria – Odpowiedź na potrzebę budowania wspólnoty i wzajemnego wspierania się mężczyzn w drodze do prawdziwej Męskości."""),

          StaffMemberCard(name: 'Gabrysia Jędrszczyk', title: "Przęsło kulturalne", imagePath: "assets/photos/Gabrysia-Jedrszczyk-600x600.jpg", description: ''''“Wspolnota- to to, co tworzymy w Moście. Trudno tworzyć wspólnotę nie znając się wzajemnie. W związku z tym przęsło kulturalne wychodzi z inicjatywą wspólnych integracji.
              W każdy czwartek o godz. 20 spotykamy się, aby spędzić ze sobą czas na tematycznych imprezach tanecznych, pomysłowych wieczorkach kulturalnych czy grając w niezastapione gry planszowe. Osoby ze zdolnościami plastycznymi mogą się wykazać tworząc dekoracje na nasze wydarzenia. Wychodzimy również wspólnie na spektakle i koncerty, aby delektować się sztuką.
              Jak powiedział ksiądz Bosko: “”Szatan boi się ludzi radosnych””!
              Cieszmy się wspólnym przebywaniem ze sobą. Do zobaczenia!”'''),

          StaffMemberCard(name: 'Faustyna Orczyk', title: "Przęsło medialne", imagePath: "assets/photos/Faustyna-Orczyk-1-600x600.jpg", description: '''Głosimy Dobro w każdym pikselu!

Jesteśmy przęsłem medialnym i to my dbamy o to, by nasze Duszpasterstwo było widoczne- zarówno online, jak i offline! Tworzymy grafiki, robimy zdjęcia upamiętniając ważne dla nas chwile oraz nagrywamy filmy, by pokazać piękno tego co się u nas dzieje oraz młodych serc, zaprawionych Salezjańskim Duchem. Piszemy artykuły, które inspirują i przekazują ważne treści, a także działamy w social mediach. W skrócie dbamy o nasz wizerunek od strony wizualnej, ale i technicznej. Każdy znajdzie dla siebie tutaj miejsce.

Jeśli chcesz rozwijać swoje pasje, rozwijać swoją kreatywność i działać w świetniej ekipeie dołącz do nas!'''),

          StaffMemberCard(name: 'Magda Czado', title: "Przęsło gospodarcze", imagePath: "assets/photos/Magda-Czado-600x600.jpg", description: '''W naszym przęśle dbamy o wszystkie elementy, które składają się na MOST, czyli zarówno o nas samych, jak i o sprzęty, których używamy, czy pomieszczenia, w których przebywamy. Wiadomo, że wspólne posiłki gromadzą i integrują ludzi, dlatego spotykamy się przy wspólnym stole na obiadach i kolacjach tak często, jak to tylko możliwe.

              Pragnąc nagrodzić zaangażowanie na rzecz duszpasterstwa, stworzyliśmy system punktowy, który umożliwia zdobycie wejściówki na imprezę czy MOSTowych gadżetów np. koszulki lub długopisu.'''),

          StaffMemberCard(name: 'Jan Maziarski', title: "Przęsło sportowe", imagePath: "assets/photos/Janek-Maziarski-600x600.jpg", description: '''MOST to miejsce, w którym dbamy o relacje z Bogiem i z ludźmi. Idealną okazją do takiej integracji są aktywności sportowe!

Zapraszamy Was na kultową “Salkę z MOSTem”, a więc wspólne granie w piątkowe wieczory w siatkówkę, koszykówkę lub unihokeja. Informacja o wyjściu jest podawana na MOSTowych kolacjach oraz na grupie duszpasterstwa.

Jednym z podprzęseł są Aktywności Fizyczne, gdzie na pewno znajdziesz choć jeden sport dla siebie! Nie przejmuj się, jeżeli nie masz jeszcze sprzętu, ani umiejętności. Nasi podprzęsłowi zadbają o to, byś mógł znaleźć coś, co Tobie odpowiada!

Osoby zainteresowane e-sportem i innymi aktywnościami zdalnymi, zapraszamy na discordową grupę naszego przęsła! Zachęcamy też do dołączenia do naszej grupy na facebooku, gdzie będą się pojawiać wszelkie informacje dotyczące wydarzeń sportowych organizowanych w moście.'''),

          StaffMemberCard(name: 'Julia Pasternak', title: 'Przęsło "dla Innych""', imagePath: "assets/photos/Julia-Pasternak-600x600.jpg", description: '''Nieraz trudno znaleźć w sobie siłę do działania, a czasem potrzeba tak niewiele, by sprawić radość! Jeżeli chcesz poświęcić trochę swojego czasu innym, to tutaj znajdziesz na to przestrzeń. Możesz przekazać swoją wiedzą na mostowych Korepetycjach, odkryć radość wewnętrznego dziecka razem z Dziećmi poMOSTowymi, podzielić się swoim sercem z Dziewczynami zza płota oraz zaangażować w Wolontariat. Jeśli chcesz spróbować swoich sił – po prostu przyjdź! Czekamy właśnie na Ciebie.'''),

          StaffMemberCard(name: 'Benedykt Szymański', title: "Przęsło turystyczne", imagePath: "assets/photos/Janek-ChudzikQuke-600x600.jpg", description: '''Nie ma niczego na świecie, czego nie możemy się podjąć, jeśli tylko chcemy spróbować. Wystarczy odrobina odwagi i zaufania. Tutaj chcemy wyjść naprzeciw życiu, dojść tam, gdzie na co dzień nie mamy czasu pójść. Czy chcecie zdobyć góry, przepłynąć rzeki, zwiedzić coś, co dotąd widzieliście tylko na zdjęciach – tutaj chcemy dać Wam tą możliwość. “Podróże kształcą” – jest naszym mottem. Wspólnie wychodzimy z domów, by przeżyć przygodę, która długo pozostanie w Naszej pamięci. Chcecie dołączyć? Czekamy na każdego z Was.'''),

          StaffMemberCard(name: 'Hania Wesołowska', title: "Przęsło muzyczne", imagePath: "assets/photos/Janek-ChudzikQuke-600x600.jpg", description: '''A my wierzymy, że dźwięki mogą łączyć pasję, wiarę i wspólnotę!

Naszym głównym celem jest upiększanie Mostowych Eucharystii – śpiewamy i posługujemy muzycznie podczas Mszy przez cały tydzień (oprócz wtorków i sobót), a przed każdą z nich spotykamy się na próbie o 18:30. Najważniejszym momentem tygodnia jest niedzielna Eucharystia, do której przygotowujemy się na próbie o 18:00.

Repertuar? Różnorodny! Sięgamy po nowoczesne aranżacje, ale i piękno tradycji – każdy znajdzie tu coś dla siebie!

Schola to jednak coś więcej niż śpiew… To miejsce, gdzie budujemy przyjaźnie, wspólnotę i siebie samych. To przestrzeń do rozwijania talentów, przełamywania barier i wspólnego tworzenia czegoś wyjątkowego.

Co jeszcze robimy? Organizujemy charytatywne wieczorki muzyczne, podczas których możemy posłuchać talentów naszych Mostowiaków i poczuć magię muzyki na stolarnianej scenie.
Jeśli jesteś muzykiem, samoukiem, osobą kochającą muzykę lub po prostu przez chwilę pomyślałeś “”To brzmi super”” – wpadnij do nas! Nie musisz mieć doświadczenia, wystarczy pasja i chęć bycia częścią czegoś pięknego.

Masz pytania? Skontaktuj się z przęsłową lub podprzęsłowymi – na pewno rozwieją Twoje wątpliwości! Do zobaczenia! “'''),

          const SectionHeader(text: 'Podprzęsłowi'),

          StaffMemberCard(name: 'Martyna Stanecka', title: "Valdocco (adoracja uwielbieniowa)", imagePath: "assets/photos/Martyna-Stanecka-600x600.jpg", description: '''Jak najlepiej poznać Boga? Najprościej — spędzając z Nim trochę czasu sam na sam. W ciszy spotkania możemy odkrywać Jego głęboką i piękną Miłość. A przecież nie ma nic wspanialszego niż doświadczyć Jego miłosierdzia i łaski. Aby razem uwielbiać naszego Boga, spotykamy się w każdą trzecią środę miesiąca na Valdocco — adoracji uwielbieniowej. Idąc za przykładem św. Jana Bosko, chcemy stawiać Boga na pierwszym miejscu i wzrastać w Jego obecności.
Jak Valdocco dla ks. Bosko było miejscem początku, tak dla nas staje się przestrzenią spotkania i wzrastania w wierze.'''),

          StaffMemberCard(name: 'Ola Pydo', title: "Valdocco (adoracja uwielbieniowa)", imagePath: "assets/photos/Ola-Pydo-600x600.jpg", description: '''Jak najlepiej poznać Boga? Najprościej — spędzając z Nim trochę czasu sam na sam. W ciszy spotkania możemy odkrywać Jego głęboką i piękną Miłość. A przecież nie ma nic wspanialszego niż doświadczyć Jego miłosierdzia i łaski. Aby razem uwielbiać naszego Boga, spotykamy się w każdą trzecią środę miesiąca na Valdocco — adoracji uwielbieniowej. Idąc za przykładem św. Jana Bosko, chcemy stawiać Boga na pierwszym miejscu i wzrastać w Jego obecności.
Jak Valdocco dla ks. Bosko było miejscem początku, tak dla nas staje się przestrzenią spotkania i wzrastania w wierze.'''),

          StaffMemberCard(name: 'Karolina Naróg', title: "Misja Specjalna", imagePath: "assets/photos/Karolina-Narog-600x600.jpg", description: '''Chciałeś kiedyś wyruszyć na misje? Teraz masz taką szansę! To misja wyjątkowa — modlitwy za naszych duchowych pasterzy. Od niej zależy, jak owocnie będą prowadzić nas i innych do Boga.

Na czym dokładnie to polega?
Każdy z nas losuje raz w tygodniu jednego z duszpasterzy MOSTu, ks. Mateusza, ks. Dawida lub siostrę Natalię i przez tydzień codziennie modli się za wylosowaną osobę dowolną modlitwą. To im zawdzięczamy duchowy (i nie tylko) rozwój w naszym duszpasterstwie. Otoczmy ich naszą pamięcią modlitewną!'''),

          StaffMemberCard(name: 'Roman Switana', title: "Duchowa Adopcja", imagePath: "assets/photos/Roman-Svitana-600x600.jpg", description: '''Czy miałeś kiedyś poczucie, że Bóg daje Ci zadania na miarę czasów, w których żyjesz? Jeśli tak, to stwórz szansę dzieciom nienarodzonym, a zagrożonym zabiciem w łonie matki, zasmakować pierwszego zachwytu nad pięknem świata, poznawaniem drugiego człowieka i siebie samego.

Na czym owa duchowa adopcja polega?

W ramach adopcji, która rozpoczyna się uroczystym przyrzeczeniem, modlisz się dziesiątką różańca przez okres 9 miesięcy za swoje adoptowane dziecko.

5 min * 30 dni * 9 miesięcy = 1350 minut = 22,5 godziny, czyli ok. 1 doba Twojego życia = 1 życie pewnego człowieka.

Więcej informacji na podstronie Duchowej Adopcji.'''),

          StaffMemberCard(name: 'Kasia Chodor', title: "Skrzynka intencji", imagePath: "assets/photos/Kasia-Chodor-600x600.jpg", description: '''Czy jesteś w stanie poświęcić trochę swojego czasu na modlitwę za innych ludzi, by im w pokorny sposób pomóc i ulżyć w różnych troskach i problemach? Tutaj właśnie stwarzamy na to przestrzeń. Do naszej skrzynki z intencjami każdy może wpisać swoje prośby, w czym możemy go wspomóc w modlitwie – a my, to robimy. Modlimy się w wybranych intencjach dowolną formą. Różaniec, Tabor, koronka, dobry uczynek… każda odpowiedź jest dobra. Oprócz modlitwy indywidualnej intencje są czytane podczas modlitwy wiernych na niedzielnych i środowych Mszach MOSTowych.

W jakich intencjach się modlimy? We wszystkich intencjach przesyłanych do skrzynki oraz w intencjach stałych:

w intencjach Ojca Świętego,
w intencji dusz w czyśćcu cierpiących,
za siebie nawzajem w grupie modlitwy wstawienniczej,
za nasze duszpasterstwo,
za osoby podejmujące odpowiedzialność w Moście,
za duszpasterzy MOSTu,
za naszą ojczyznę i za rządzących,
w intencji dzieci nienarodzonych, zagrożonych aborcją,
o powołania do kapłaństwa i życia zakonnego z MOSTu,
o powołania do życia małżeńskiego z MOSTu,
za „Dziewczyny zza płota”,
za pary uczestniczące w kursie przedmałżeńskim,
w intencji misji i misjonarzy salezjańskich.
Co trzeba zrobić, aby do nas dołączyć i otrzymywać maile z intencjami? Wystarczy skontaktować się z podprzęsłowym:)'''),

          StaffMemberCard(name: 'Marta Trębacka', title: "Duchowe środy – Iloraz", imagePath: "assets/photos/Marta-Trebacka-600x600.jpg", description: '''Iloraz – czyli dzielenie.
To środowe spotkania po Mszy akademickiej, podczas których znajdziesz przestrzeń, by podzielić się swoimi przemyśleniami, posłuchać innych i wspólnie poszukać odpowiedzi na życiowo-duchowe pytania.
W otwartej rozmowie możesz poznać różne perspektywy, spojrzeć na świat oczami drugiego człowieka i zostawić po sobie coś dobrego. Każdy ma tu głos i jest ważny.
Na zakończenie spotkania trwamy razem na adoracji, powierzając Bogu nasze myśli, rozmowy i intencje.
Serdecznie zapraszamy — nie może Cię zabraknąć!'''),

          StaffMemberCard(name: 'Marcelina Prenger', title: "Dzień skupienia", imagePath: "assets/photos/Marcelina_Prenger-600x600.jpg", description: '''Czy zastanawiałeś się kiedyś, jak dobrze przeżyć każdy dzień swojego życia?
Zapraszamy Cię na Dzień Skupienia – wyjątkowy czas zatrzymania i spotkania z Bogiem. W duchu św. Jana Bosko uczymy się wdzięczności za życie, refleksji nad tym, co naprawdę ważne, i gotowości na spotkanie z Bogiem w codzienności.
To moment, by złapać oddech, wyciszyć się, odnaleźć pokój serca i umocnić swoją wiarę. Wspólna modlitwa, cisza i rozmowa pomagają spojrzeć na życie z nowej perspektywy – pełnej nadziei i radości.
Przyjdź i przeżyj ten czas razem z nami!


'''),

          StaffMemberCard(name: 'Łukasz Mróz', title: "Służba Liturgiczna", imagePath: "assets/photos/Lukasz-Mroz-600x600.jpg", description: '''Służba Liturgiczna, czyli po prostu ministranci, zajmuje się oprawą Mszy Św. od strony „technicznej”. Jesteśmy grupą studentów, którzy pragną pomóc wszystkim przeżyć Mszę Świętą w prostocie i skupieniu.

Każda Msza Święta zawiera w swoich obrzędach wiele symboli, które poznajemy na naszych spotkaniach, a także formujemy się, by w pełnej świadomości tego, co się dzieje, przystępować do naszej posługi.

Jesteśmy otwarci na nowych członków przez cały rok, więc nigdy nie jest za późno by do nas dołączyć! Pamiętamy również, że słowo „ministrant” pochodzi od łacińskiego słowa „ministrare” co oznacza „służyć”, „pomagać”. Zatem i my, Służba Liturgiczna, służymy i pomagamy!'''),

          StaffMemberCard(name: 'Igor Ciesielski', title: "Oprawa liturgii", imagePath: "assets/photos/Igor-Ciesielski-600x600.jpg", description: '''Czy zastanawiałeś/łaś się kiedyś nad tym jak to się dzieje, że w czasie Mszy Św. są osoby, które czytają czytania, komentarze, podchodzą z darami do Ołtarza, zanoszą prośby w czasie modlitwy wiernych, wyśpiewują Bogu psalm – pewnie nie, bo wydaje się to oczywiste. Przęsło liturgiczne czuwa nad tym, by angażować ludzi do różnych posług w czasie Eucharystii, rekolekcji, nabożeństw, różańca i Taboru.

Pięknie jest przeżywać Eucharystię we wspólnocie ludzi, którzy są żywo zaangażowani i dają coś z siebie innym. Tu nie potrzeba nie wiadomo jakich talentów, wystarczy odważyć się, przełamać swoje opory, a Liturgia nabiera zupełnie nowego znaczenia.'''),

          StaffMemberCard(name: 'Anastasiia Babych', title: "Różaniec", imagePath: "assets/photos/Anastasiia-Babych-600x600.jpg", description: '''Różaniec… Wymaga czasu, koncentracji uwagi, poświęcenia – na to nas właśnie stać! Dostrzegamy w naszym życiu jego piękno i siłę. Różaniec uczy nas dyscypliny i wytrwałości. Jest więc nie tylko modlitwą, lecz także środkiem uświęcenia i postępu duchowego. Pomaga się wyciszyć i w skupieniu, wraz z Maryją, kontemplować tajemnice z życia naszego Zbawiciela.

Powierzamy ufnie, w modlitwie różańcowej, wszystko co leży nam na sercu. Poniedziałek, godz. 18:40. Do zobaczenia! Zachęcamy również, aby stać się członkiem MOSTowego Żywego Różańca! Żywy Różaniec, jest modlitwą wspólnotową. Składa się z Róż, czyli dwudziestoosobowych grup, w których każda osoba odmawia codziennie wraz z rozważaniem jedną dziesiątkę różańca, czyli jedną tajemnicę. Dzięki temu każdego dnia odmawiany jest w Róży cały Różaniec – dwadzieścia tajemnic. Zatem codziennie w swojej Róży uczestniczymy w całym Różańcu, a także w odpustach przywilejach i owocach duchowych Kościoła, które związane są z tą praktyką.

Raz w miesiącu, jako członkowie Żywego Różańca, wymieniamy się tajemnicami różańcowymi. Modlimy się w intencjach podanych na dany miesiąc oraz w intencjach stałych. Serdecznie zapraszamy!'''),

          StaffMemberCard(name: 'Natalia Poźniak', title: "Tabor", imagePath: "assets/photos/Natalia-Pozniak-600x600.jpg", description: '''W piątek spotykamy się przy kaplicy na wspólnej adoracji Najświętszego Sakramentu. Specjalnie dla chwili, żeby pobyć z Bogiem we wspólnocie w towarzystwie Słowa, śpiewu i ciszy.

Zaczynamy w każdy piątek o 20:00 po Mszy Świętej. W trakcie adoracji można skorzystać ze spowiedzi.'''),

          StaffMemberCard(name: 'Mateusz Padarz', title: "Rzutnik", imagePath: "assets/photos/Mateusz-Padarz-600x600.jpg", description: '''Zastanowiło was kiedyś, jak to jest możliwe, że na rzutniku w naszym kościele pojawiają się słowa piosenek? To zasługa „tekstomiotów”, osób, które formatują teksty i obsługują rzutnik podczas MOSTowych Mszy oraz innych wydarzeń takich jak adoracje czy czuwania. Jeśli chcesz zaangażować się w tę formę uczestniczenia w liturgii to koniecznie zgłoś się do przęsłowego lub szefa podprzęsła. Wszystkiego Cię nauczymy.'''),

          StaffMemberCard(name: 'Jakub Koszewski', title: "Reflektor", imagePath: "assets/photos/Jakub-Koszewski-600x600.jpg", description: '''Spotkania dyskusyjne. Podejmujemy na nich tematy, które nas, studentów, młodych ludzi nurtują: polityka, światopogląd, zdrowie, duchowość, nauka. Jest to wspaniała okazja aby się wypowiedzieć oraz usłyszeć zdanie innych.'''),

          StaffMemberCard(name: 'Jakub Staniszewski', title: "CUD", imagePath: "assets/photos/Jakub-Staniszewski-600x600.jpg", description: '''CUD, czyli Ciało Uczucia Duch.

Jest to tytuł tegorocznego cyklu formacyjnego- wtorkowych spotkań, na których zaproszeni prelegenci wypowiadają się na określony temat.
W tym semestrze prelekcje będą dotyczyły m.in. cielesności, relacji, związków i powiązanej z nimi duchowości.

Spotkania odbywają się w wybrane wtorki o godzinie 20:15 w Stolarni.'''),

          StaffMemberCard(name: 'MKF', title: "Wojciech Cybulak", imagePath: "assets/photos/Wojciech-Cybulak-600x600.jpg", description: '''Mostowy Klub Filmowy to spotkanie, na którym wspólnie oglądamy wartościowy film, z którego można wynieść coś dla siebie. Po seansie dzielimy się tym, co nas poruszyło, wywołało radość lub wzbudziło inne emocje. Po podzieleniu się wrażeniami rozpoczynamy dyskusję.'''),

          StaffMemberCard(name: 'Paweł Gierkowski', title: "Boska Husaria", imagePath: "assets/photos/Pawel-Gierowski-600x600.jpg", description: '''Wyjazdowe spotkania mężczyzn, na których, wracamy do momentu naszego stworzenia będąc w otoczeniu dzikiej natury. Wchodzimy wtedy w przygodę, budujemy wspólnotę, rozmawiamy o tym, jak szukamy swojego powołania, naszej relacji z Bogiem, co jest dla nas ważne w życiu i co przeżywamy.


'''),

          StaffMemberCard(name: 'Alicja Radomyska', title: "Lectio Divina", imagePath: "assets/photos/Kobieta-awatar.jpg", description: '''Chcesz poznać Słowo, ale ciężko Ci się za to zabrać? Może czytasz Pismo Święte, ale niewiele z niego rozumiesz? Nie jesteś sam! A my spotykamy się, aby Ci pomóc.

Lectio divina to praktyka, w trakcie której rozważamy Ewangelię z nadchodzącej niedzieli. Spotykamy się w poniedziałki, dzięki czemu mamy prawie cały tydzień na rozważenie w swoich sercach Słowa, z którym zetkniemy się w trakcie niedzielnej Mszy Świętej.

Jak to wygląda?

LECTIO – czyli dokładne przeczytanie fragmentu, zadanie wszelkich nurtujących nas pytań i odpowiedzenie na nie ze wsparciem stworzonych przez biblistów komentarzy oraz naszego duszpasterza.
MEDITATIO – wprowadza nas pełniej w tajemnicę Słowa. To czas dla każdego z nas na rozmyślanie i otwarcie się na działanie Ducha.
ORATIO – wspólna modlitwa, w której oddajemy Bogu wszystko co leży nam na sercu i prosimy o Jego wsparcie.
ACTIO – jest zwieńczeniem spotkania pozwalające nam na (dobrowolne) podzielenie się z innymi tym, co nas poruszyło w Słowie, z którym się spotkaliśmy.
Po spotkaniu prosimy kilka chętnych osób o napisanie krótkich przemyśleń związanych z rozważaną przez nas Ewangelią. Zostaną one zebrane w formie książkowej. Na wszystkich zainteresowanych czekamy z gorącą herbatą po poniedziałkowej Mszy, ok. godz. 20!'''),

          StaffMemberCard(name: 'Paweł Kuśnierz', title: "Imprezy", imagePath: "assets/photos/Pawel-Kusnierz-600x600.jpg", description: '''Św. Augustyn powiedział: “Człowieku, naucz się tańczyć, bo inaczej aniołowie w niebie nie będą wiedzieli, co z tobą zrobić.” Zainspirowani tymi słowami, kilka razy w semestrze, zamieniamy Stolarnię w parkiet taneczny, na którym możecie spróbować swoich sił i po prostu dobrze się bawić.

Impreza w stylu Star Wars, szykownego Paryża, wesołego miasteczka czy też lat 80… Przyjdź i zobacz, jaka będzie następna!'''),

          StaffMemberCard(name: 'Izabela Prędkiewicz', title: "Wyjścia", imagePath: "assets/photos/izabela-Predkiewicz-600x600.jpeg", description: '''Marzysz o tym, żeby wybrać się do opery, teatru lub na koncert, ale zawsze było jakoś nie po drodze? Mamy dla Ciebie dobrą wiadomość – okazja zbliża się wielkimi krokami!

Pójdziemy na spacer szlakiem wrocławskich krasnali. Może zwiedzimy Muzeum Narodowe albo wybierzemy się na festiwal filmowy. Zjemy razem pizzę w nowo otwartej pizzerii lub spędzimy emocjonujący wieczór na kręglach. Krótko mówiąc, wybierzemy najlepsze z kulturalnych propozycji Wrocławia i udowodnimy, że MOST buduje się nie tylko przy Placu Grunwaldzkim.

Śledź wiadomości na stronie, a na spotkania zabieraj ze sobą znajomych. Jeśli masz własne pomysły, daj znać.'''),

          StaffMemberCard(name: 'Emilia Jastrzębska', title: "Wieczorki", imagePath: "assets/photos/Emilia-Jastrzebska-600x600.jpg", description: '''Kulturalne czwartki to przestrzeń naszej integracji. Spotykamy się, by poznać nawet osoby podczas Speed Talkingu, pograć w planszowki, nauczyć się tańczyć podczas kursu tańca czy pośpiewać podczas karaoke.
To przestrzeń, by podzielić się swoimi pasjami na MostX, kreatywnie spędzić czas i nawiązać  nowe relacje.
Jeśli chcesz dowiedzieć, co będzie się działo w ten czwartek, sprawdź nasz kalendarz i śledź social media. Zapraszamy! Będzie Bosko!'''),

          StaffMemberCard(name: 'Agnieszka Prykowska', title: "Wieczorki", imagePath: "assets/photos/agnieszka-prykowska-600x600.jpg", description: '''Kulturalne czwartki to przestrzeń naszej integracji. Spotykamy się, by poznać nawet osoby podczas Speed Talkingu, pograć w planszowki, nauczyć się tańczyć podczas kursu tańca czy pośpiewać podczas karaoke.
To przestrzeń, by podzielić się swoimi pasjami na MostX, kreatywnie spędzić czas i nawiązać  nowe relacje.
Jeśli chcesz dowiedzieć, co będzie się działo w ten czwartek, sprawdź nasz kalendarz i śledź social media. Zapraszamy! Będzie Bosko!'''),

          StaffMemberCard(name: 'Patrycja Tomaszewska', title: "Dekoracje", imagePath: "assets/photos/Patrycja-Tomaszewska-600x600.jpg", description: '''Nasze oczy i duszę cieszy piękny wystrój – dlatego dbamy o klimat w MOSTowych pomieszczeniach. Gdy nadchodzą ważne dla wspólnoty wydarzenia lub odwiedzają nas goście, salki zamieniają się w zupełnie inne przestrzenie! Nie inaczej jest podczas tanecznych imprez tematycznych, gdzie dekoracje dodają klimatu zabawie.Chcesz się przekonać – przyjdź i zobacz. Masz zdolności plastyczne- zaangażuj się!
Zapraszamy serdecznie!'''),

          StaffMemberCard(name: 'Marek Słowik', title: "Film", imagePath: "assets/photos/Marek-Slowik-600x600.jpg", description: '''OBRAZY, KTÓRE OPOWIADAJĄ HISTORIE Nie wszystkie momenty da się utrwalić na zdjęciu, a na pewno trudno przekazać nim coś więcej niż tylko urywek jakiejś większej całości. Dlatego właśnie to film jest tą przestrzenią do opowiadania całej historii bez niedopowiedzeń. Jeśli interesują Cię te tematy i chciałbyś opowiadać historie z naszego duszpasterstwa to podziel się tą chęcią z innymi i rób z nami piękne rzeczy.

'''),

          StaffMemberCard(name: 'Zosia Pająk', title: "Artykuły", imagePath: "assets/photos/Zosia-Pajak-600x600.jpg", description: '''SŁOWA, KTÓRE ŁĄCZĄ- Lubisz pisać? Masz w sobie duszę dziennikarza albo poetę w sercu? To właśnie jest Twoja szansa, by świat ujrzał twórczość Twoich tekstów, być może do tej pory, zakopanych na dnie szuflady. Nasze teksty informują, inspirują oraz pomagają zapamiętać najważniejsze chwile w naszym Duszpasterstwie. Dołącz do nas i pomóż Mostowi przemawiać słowami!'''),

          StaffMemberCard(name: 'Zosia Pająk', title: "Fotografia", imagePath: "assets/photos/Zosia-Pajak-600x600.jpg", description: '''CHWILE, KTÓRE ZOSTAJĄ… Lubisz łapać momenty w kadrze? Tutaj uwieczniamy życie MOSTu- od codziennych spotkań po wielkie wydarzenia. To właśnie dzięki nam przeglądając nasze social media, możesz dostrzec zdjęcia, pełne emocji, wspomnienia oraz piękno naszej wspólnoty. Obsługujemy aparaty, obrabiamy i uczymy się tworzyć historię jednym ujęciem- chwytając to co ważne.'''),

          StaffMemberCard(name: 'Patrycja Tomaszewska', title: "Grafika", imagePath: "assets/photos/Patrycja-Tomaszewska-600x600.jpg", description: '''Lubisz bawić się kolorami, tworzyć plakaty, a może projektować grafiki? To właśnie trzymasz w ręku klucz do promocji większości MOSTowych wydarzeń, nadając im barw oraz charakter. Jeżeli lubisz rysować, bądź znasz jakieś programy graficzne (Photoshop, Illustrator, Canva, Gimp), dołącz do nas i nadaj nowych kolorytów waszemu Duszpasterstwu.'''),

          StaffMemberCard(name: 'Szymon Perdek', title: "Druk", imagePath: "assets/photos/Meżczyzna-awatar.jpg", description: '''SŁOWA, KTÓRE NABIERAJĄ KSZTAŁTU…Informacja o większości MOSTowych wydarzeń rozprzestrzenia się wśród ludzi głównie poprzez plakaty. Podprzęsło ma nie lada wyzwanie, ponieważ odpowiada za to, aby były one zawsze aktulane i przyciągały uwagę szczególnie ludzi którzy jeszcze nie znają naszej MOSTowej wspólnoty.

Dołącz do nas i pomóż MOSTowi zaistnieć również na papierze!'''),

          StaffMemberCard(name: 'Bartłomiej Sitnik', title: "IT", imagePath: "assets/photos/Bartlomiej-Sitnik-600x600.jpg", description: '''TECHNICZNY FILAR MOSTU-To właśnie my zajmujemy się internetową stroną MOSTu. Porządkujemy i zamieszczamy dostarczone materiały, czasem sami coś tworzymy. Staramy się dostarczać aktualne informacje o działalności naszego duszpasterstwa.Dbamy o to by wszystko działało sprawnie. Naszym drugim zadaniem jest administracja siecią Wi-Fi w salkach duszpasterstwa, żeby zapewnić Wam szybki, wygodny dostęp do Internetu. Jeżeli masz jakieś uwagi co do funkcjonowania strony lub też pomysły na jej usprawnienie – podziel się nimi. Dołącz do nas i pomóż MOSTowi działać bez zacięć!'''),

          StaffMemberCard(name: 'Dawid Szkudlarski', title: "IT", imagePath: "assets/photos/Meżczyzna-awatar.jpg", description: '''TECHNICZNY FILAR MOSTU-To właśnie my zajmujemy się internetową stroną MOSTu. Porządkujemy i zamieszczamy dostarczone materiały, czasem sami coś tworzymy. Staramy się dostarczać aktualne informacje o działalności naszego duszpasterstwa.Dbamy o to by wszystko działało sprawnie. Naszym drugim zadaniem jest administracja siecią Wi-Fi w salkach duszpasterstwa, żeby zapewnić Wam szybki, wygodny dostęp do Internetu. Jeżeli masz jakieś uwagi co do funkcjonowania strony lub też pomysły na jej usprawnienie – podziel się nimi. Dołącz do nas i pomóż MOSTowi działać bez zacięć!

'''),

          StaffMemberCard(name: 'Dominika Szymala', title: "Programowanie", imagePath: "assets/photos/Dominika-Szymala-600x600.jpg", description: '''KOD, KTÓRY ŁĄCZY- To my zajmujemy się cyfrową stroną MOSTU. Przygotowujemy aplikację, zajmujemy się stroną Duszpasterstwa, ulepszamy sytemy, tworzymy narzędzia, które ułatwiają organizację i eksperymentujemy z nowymi technologiami. Dołącz do nas i pomóż MOSTowi działać w sieci!'''),

          StaffMemberCard(name: 'Marek Słowik', title: "Instagram", imagePath: "assets/photos/Marek-Slowik-600x600.jpg", description: '''W naszym podprzęśle dbamy o to by tworzyć treści, które przyciągną, ale i zatrzymają Was na dłużej, a oprócz tego informują i inspirują. Posty, rolki, relacje są naszymi dziełami, o których jakość dbamy w najmniejszych szczegółach by troszczyć się o estetykę oraz kontakt z obserwującymi. Pokazujemy że Duszpasterstwo to nie tylko spotkania, ale również przestrzeń pełna życia, radości i wiary.
Lubisz wcielić się czasem w rolę reportera, bądź po prostu lubisz prowadzić Instagrama? Dołącz do nas i pomóż MOSTowi docierać dalej!'''),

          StaffMemberCard(name: 'Wiktoria Sebzda', title: "Instagram", imagePath: "assets/photos/Wiktoria-Sebzda-600x600.jpg", description: '''W naszym podprzęśle dbamy o to by tworzyć treści, które przyciągną, ale i zatrzymają Was na dłużej, a oprócz tego informują i inspirują. Posty, rolki, relacje są naszymi dziełami, o których jakość dbamy w najmniejszych szczegółach by troszczyć się o estetykę oraz kontakt z obserwującymi. Pokazujemy że Duszpasterstwo to nie tylko spotkania, ale również przestrzeń pełna życia, radości i wiary.
Lubisz wcielić się czasem w rolę reportera, bądź po prostu lubisz prowadzić Instagrama? Dołącz do nas i pomóż MOSTowi docierać dalej!'''),

          StaffMemberCard(name: 'Łukasz Wasilewski', title: "Tiktok", imagePath: "assets/photos/Lukasz-Wasilewski-600x600.jpg", description: '''Podprzęsło TikTok tworzy krótkie, kreatywne filmy, które łączą wiarę z codziennym życiem studentów. Relacjonujemy wydarzenia, dzielimy się inspiracjami i pokazujemy duszpasterstwo „od kuchni”. Chcesz tworzyć z nami? Dołącz!'''),

          StaffMemberCard(name: 'Weronika Gawelczyk', title: "Obiady", imagePath: "assets/photos/Weronika-Gawelczyk-600x600.jpg", description: '''Z myślą o studentach, którzy chcieliby zjeść pyszny domowy obiad, wychodzimy z propozycją wspólnych posiłków przygotowywanych w naszej Mostowej kuchni. Codziennie można się na nie zapisywać poprzez grupkę MOSTu na Facebooku. Jeśli więc chciałbyś służyć, gotując z nami w Moście, to pisz do wskazanej tutaj podprzęsłowej, każda pomoc się przyda! Oprócz zdobycia doświadczenia kulinarnego, w tym podprzęśle, będziesz mieć okazję do współpracy z innymi oraz integracji. Moźesz być pewny, że studenci odpłacą się uśmiechem i słowami „Było pyszne” :)'''),

          StaffMemberCard(name: 'Stanisław Myka', title: "Sprawy techniczne", imagePath: "assets/photos/Meżczyzna-awatar.jpg", description: '''Podprzęsło bardzo potrzebne w Moście. Dba o wszelkie sprawy techniczne w naszym duszpasterstwie, od wymieniania oświetlenia, po naprawę mebli. Gdyby nie ci odważni mężczyźni, z czasem nie mielibyśmy pewnie na czym siedzieć w Moście, a wieczorem poruszalibyśmy się po omacku. Także jeśli zauważysz, że w Moście coś nie działa, to daj znać chłopakom, a oni postarają się coś zaradzić.'''),

          StaffMemberCard(name: 'Tosia Rachwał', title: "Kolacje", imagePath: "assets/photos/Tosia-Rachwal-600x600.jpg", description: '''Kolacje to czas i przestrzeń na spotkanie po wieczornej mszy świętej. To doskonała okazja, aby zaangażować się i poznać nowych ludzi. Przygotowujemy razem kolację – możesz pomóc w robieniu kanapek, sałatki czy upiec ciasto. Po posiłku jest czas na rozmowy, integrację i dobrą atmosferę. Jeśli chcesz się zaangażować, daj znać wskazanej tutaj podprzęsłowej. Do zobaczenia podczas przygotowywania, a potem przy wspólnym stole!'''),

          StaffMemberCard(name: 'Michał Herbut', title: "Porządki", imagePath: "assets/photos/Michal-Herbut-600x600.jpg", description: '''Jak w domu, tak i w Moście czasem trzeba posprzątać. To podprzęsło zajmuje się właśnie tym, by utrzymywać porządek w duszpasterstwie. Czasem wystarczy krótka chwila, by wytrzeć podłogę w jakimś pomieszczeniu, zetrzeć kurze albo pozmywać naczynia po posiłku, a dzięki temu żyje nam się w Moście dużo lepiej. Dlatego nie bójcie się i zgłaszajcie się do podprzęsłowego, gdy macie chwilę by służyć pomocą.'''),

          StaffMemberCard(name: 'Agata Kuśmierek', title: "Porządki w tygodniu", imagePath: "assets/photos/Kobieta-awatar.jpg", description: '''Jak w domu, tak i w Moście czasem trzeba posprzątać. To podprzęsło zajmuje się właśnie tym, by utrzymywać porządek w duszpasterstwie. Czasem wystarczy krótka chwila, by wytrzeć podłogę w jakimś pomieszczeniu, zetrzeć kurze albo pozmywać naczynia po posiłku, a dzięki temu żyje nam się w Moście dużo lepiej. Dlatego nie bójcie się i zgłaszajcie się do podprzęsłowego, gdy macie chwilę by służyć pomocą.

Co czwartek o 15:00 wspólnie sprzątamy nasze salki. Zapraszamy Cię do pomocy!'''),

          StaffMemberCard(name: 'Maciej Karczewski', title: "Zaopatrzenie", imagePath: "assets/photos/Maciej-Karczewski1-600x600.jpg", description: '''Kolacje, obiady, sprawy techniczne, porządki – to wszystko nie odbyłoby się bez niezbędnych składników czy przedmiotów. Dlatego właśnie mamy podprzęsło zajmujące się robieniem zakupów, gdy czegoś brakuje. Kiedy więc zobaczysz, że w spiżarni skończył się cukier albo w ferworze porządków złamała się miotła – nie bój się i daj znać!'''),

          StaffMemberCard(name: 'Mikołaj Uryga', title: "Salka", imagePath: "assets/photos/Mikolaj-Uryga-600x600.jpg", description: '''Sala sportowa to miejsce, gdzie możesz razem z nami pograć w gry zespołowe i zadbać o swoją kondycję fizyczną. Przeważnie gramy w siatkówkę, koszykówkę i unihokeja, ale jesteśmy otwarci na inne rodzaje gier zespołowych. Wszystko zależy od was – uczestników.

Spotykamy się w piątki w godz.: 22:00 – 24:00, na hali sportowej Uniwersytetu Przyrodniczego, która znajduje się przy ul Chełmońskiego 43. Zapisać możesz się poprzez naszą facebook’ową grupę – SDA MOST lub podczas niedzielnej kolacji. Jeśli zgłosisz się do środy, wejście będzie kosztowało 15 zł, a po tym terminie 20 zł. Liczba miejsc jest ograniczona.

Pytania odnośnie salki proszę kierować do szefa przęsła, szefa podprzęsła lub pomocnika szefa podprzęsła.'''),

          StaffMemberCard(name: 'Paulina Wojewoda', title: "Wolontariat", imagePath: "assets/photos/Paulina-Wojewoda-600x600.jpg", description: '''Jeżeli lubisz pomagać innym i dzielić się swoim sercem, to podprzęsło jest właśnie dla Ciebie. W tym szeroko rozumianym haśle “wolontariat” będziesz miał okazję pójść na wspólne Krwiodawstwo, zaangażować się w Paczuszkę dla Maluszka oraz wiele innych. Nie potrzebne są żadne umiejętności, wystarczy trochę otwartości serca i dobrych chęci.'''),

          StaffMemberCard(name: 'Julia Pasternak', title: "Dzieci poMOSTowe", imagePath: "assets/photos/Julia-Pasternak-600x600.jpg", description: '''„Dzieci są jedynymi ludźmi, którym nigdy się nie nudzi.”

Chcesz poczuć dziecięcą radość? Masz trochę wolnego czasu? Lubisz czytać bajki dzieciom, budować zamki z patyczków, czy grać w gry planszowe? Jeśli tak to…

Zapraszam na Dzieci poMOSTowe! Podczas Spotkań Małżeńskich dzieci potrzebują opieki, dlatego jest to zadanie dla Ciebie ;)

Pomoc przy dzieciach jest potrzebna w niedziele, nieregularnie – dlatego śledźcie mostowy Kalendarz.'''),

          StaffMemberCard(name: 'Marta Naróg', title: "Dziewczyny zza płota", imagePath: "assets/photos/Marta-Narog-600x600.jpg", description: '''Tajemniczo brzmiące Dziewczyny zza płota są naszymi sąsiadkami, wychowankami Młodzieżowego Ośrodka Wychowawczego prowadzonego przez Siostry Matki Bożej Miłosierdzia. Pobyt w ośrodku jest dla nich szansą na powrót do szkoły i w przyszłości prowadzenie całkowicie normalnego życia w przypadku, gdy popełniły wykroczenia, które decyzją sądu nie wymagają dotkliwszej kary.

W czasie spotkań umilamy im czas grami, zabawą, wspólnym oglądaniem filmów, a przede wszystkim rozmawiamy i ewangelizujemy. Te małe „lekcje religii” są także lekcjami dla nas, to doświadczenie pokory, nauka cierpliwości i trenowanie wytrwałości.

Na spotkanie może przyjść każdy, nie wymagamy nic więcej ponad otwartość i dobre chęci.

Kiedy? W środy o 17:00. Gdzie? Spotykamy się w salce MOSTu i stamtąd wspólnie wychodzimy.

Zachęcamy, by przyjść przed czasem i z wyprzedzeniem poznać plan spotkania.'''),

          StaffMemberCard(name: 'Kamila Kinasz', title: "Dziewczyny zza płota", imagePath: "assets/photos/Kamila-Kinasz-600x600.jpg", description: '''Tajemniczo brzmiące Dziewczyny zza płota są naszymi sąsiadkami, wychowankami Młodzieżowego Ośrodka Wychowawczego prowadzonego przez Siostry Matki Bożej Miłosierdzia. Pobyt w ośrodku jest dla nich szansą na powrót do szkoły i w przyszłości prowadzenie całkowicie normalnego życia w przypadku, gdy popełniły wykroczenia, które decyzją sądu nie wymagają dotkliwszej kary.

W czasie spotkań umilamy im czas grami, zabawą, wspólnym oglądaniem filmów, a przede wszystkim rozmawiamy i ewangelizujemy. Te małe „lekcje religii” są także lekcjami dla nas, to doświadczenie pokory, nauka cierpliwości i trenowanie wytrwałości.

Na spotkanie może przyjść każdy, nie wymagamy nic więcej ponad otwartość i dobre chęci.

Kiedy? W środy o 17:00. Gdzie? Spotykamy się w salce MOSTu i stamtąd wspólnie wychodzimy.

Zachęcamy, by przyjść przed czasem i z wyprzedzeniem poznać plan spotkania.'''),

          StaffMemberCard(name: 'Antoni Śmidoda', title: "Korepetycje MOSTowe", imagePath: "assets/photos/Antoni-Smidoda-600x600.jpg", description: '''Lubisz nieść pomoc innych? To właśnie w tym podprzęśle rozwiniesz swoje skrzydła. Od tego semestru będziemy udzielać korepetycji u Dziewczyn z Młodzieżowego Ośrodka Wychowawczego, dlatego jeśli pragniesz sprawdzić się w roli nauczyciela to zapraszamy.'''),

          StaffMemberCard(name: 'Benedykt Szymański', title: "Biały Dunajec", imagePath: "assets/photos/Benedykt-Szymanski-600x600.jpg", description: '''Obóz Adaptacyjny Duszpasterstw Akademickich Wrocławia i Opola w myślach i sercu zawsze będzie po prostu „Białym Dunajcem”. Tak nazywa się bowiem urokliwa wieś u podnóża Tatr, gdzie co roku:

MOST wraz z innymi duszpasterstwami akademickimi Wrocławia i Opola organizuje obóz adaptacyjny dla maturzystów,
przybywa niemalże 700 studentów,
chodzimy po wspaniałych polskich Tatrach,
codziennie gromadzimy się na Mszy Świętej,
gwarantujemy wspaniałą zabawę i nieprzebraną radość!
KADRA jest wybierana z każdego duszpasterstwa. W przypadku naszego duszpasterstwa w skład kadry wchodzą:

turystyczni – przeszkolą się, by w bezpieczny sposób prowadzić uczestników na tatrzańskich szlakach i pomóc im zdobyć wymarzone szczyty,
kuchenne – zatroszczą się o nasze brzuchy i pożywną strawę,
kulturalne – nie pozwolą nam się nudzić w deszczowe dni, a wieczorami pomogą się lepiej poznać oraz przyjemnie spędzić czas i zintegrować się,
porządkowa – ma za zadanie koordynować konserwację powierzchni płaskich oraz zmywanie zastaw stołowych, a także sprawiedliwie rozdzielać dyżury sprzątające i kuchenne,
muzyczny – wydobędzie z nas skrywane talenty, uświetni liturgię,
liturgiczny – przygotuje oprawę chatkowych Mszy Świętych i zbuduje piękną świątynię nawet na łonie natury,
kwatermistrz – zadba o bezproblemowy przebieg internetowych zapisów na obóz, rozdysponuje zebranymi funduszami i zatroszczy się o godziwe miejsca noclegowe dla przybyłych uczestników i gości,
szef chaty – będzie koordynował działania kadry oraz załatwi wszystko, co będzie konieczne, by każdy uczestnik czuł się w chacie dobrze i komfortowo.
Kadra jest po to, by służyć tym, którzy przyjadą na obóz. Jak widać – każdy może podzielić się zdolnościami w odmiennych dziedzinach.

Na Biały może pojechać każdy, ale jak sama nazwa wskazuje, jest to obóz adaptacyjny, dlatego specjalne zaproszenie kierujemy do osób, które dopiero będą zaczynać studia i z duszpasterstwem nie miały jeszcze do czynienia. Organizujemy obóz właśnie po to, aby nowe osoby mogły nas poznać oraz zobaczyć, jak wygląda życie w DA i zasmakować studenckiego życia.

Jeżeli chcesz stać się częścią legendarnego, jedynego takiego w Polsce obozu adaptacyjnego w Białym Dunajcu i pomóc w jego organizacji…
Zgłoś się do nas!'''),

          StaffMemberCard(name: 'Benedykt Szymański', title: "Sylwester z MOSTem", imagePath: "assets/photos/Benedykt-Szymanski-600x600.jpg", description: '''MOST pomaga studentom przejść do następnego roku. Oferuje ku temu dogodne okoliczności:

przepiękne krajobrazy,
górskie wycieczki,
wspaniali ludzie,
5 dni wspólnej zabawy,
czas spędzony z Bogiem,
niezapomniana impreza sylwestrowa do samego rana.
Kolejnym atutem jest przystępna cena. Do tego gotujemy sami, więc jest smacznie i zdrowo, a i dokładka się znajdzie!

Tak jak na Białym Dunajcu organizacją zajmuje się kadra złożona z kwatermistrza, turystycznych, kuchennych, kulturalnych oraz osób odpowiedzialnych za liturgię, muzykę i porządek w ośrodku.

Jeżeli chcesz wziąć czynny udział w przygotowaniu tego wydarzenia – pisz śmiało. Jest jeszcze wiele do zrobienia w tym roku, ale spokojnie – nadchodzi następny!'''),

          StaffMemberCard(name: 'Mateusz Słowik', title: "Rajdy", imagePath: "assets/photos/Mateusz_Slowik-600x600.jpg", description: '''Cztery razy w roku MOST organizuje całodniowe górskie wycieczki – rajdy. Jest to idealna okazja, by poznać ludzi z naszego duszpasterstwa, a przy okazji zdobyć szczyt i nasycić oko pięknym widokiem. Każdy rajd to inne miejsce, nowe wyzwanie. Jeżeli więc jesteś człowiekiem, który lubi aktywność fizyczną, kontakt z przyrodą i innymi ludźmi – jest to propozycja właśnie dla Ciebie.

Ogłoszenia o rajdach pojawiają się z wyprzedzeniem na stronie MOSTu i podczas Mszy Św., by każdy zainteresowany otrzymał potrzebne informacje i bez pośpiechu mógł się zapisać.

Śledź uważnie informacje na stronie głównej, bo nie znasz dnia, ani godziny… Jeżeli masz jakieś pytania odnośnie wyprawy – pisz śmiało.'''),

          StaffMemberCard(name: 'Piotr Barchan', title: "Rajdy", imagePath: "assets/photos/Piotr-Barchan-600x600.jpg", description: '''Cztery razy w roku MOST organizuje całodniowe górskie wycieczki – rajdy. Jest to idealna okazja, by poznać ludzi z naszego duszpasterstwa, a przy okazji zdobyć szczyt i nasycić oko pięknym widokiem. Każdy rajd to inne miejsce, nowe wyzwanie. Jeżeli więc jesteś człowiekiem, który lubi aktywność fizyczną, kontakt z przyrodą i innymi ludźmi – jest to propozycja właśnie dla Ciebie.

Ogłoszenia o rajdach pojawiają się z wyprzedzeniem na stronie MOSTu i podczas Mszy Św., by każdy zainteresowany otrzymał potrzebne informacje i bez pośpiechu mógł się zapisać.

Śledź uważnie informacje na stronie głównej, bo nie znasz dnia, ani godziny… Jeżeli masz jakieś pytania odnośnie wyprawy – pisz śmiało.'''),

          StaffMemberCard(name: 'Bartłomiej Stężowski', title: "Ekstremalna Droga Krzyżowa", imagePath: "assets/photos/Bartlomiej-Stezowski-600x600.jpg", description: '''Ekstremalna Droga Krzyżowa, bo trzeba pokonać trasę 53 km w nocy z naszego kościoła akademickiego do sanktuarium Matki Bożej w Twardogórze, w skupieniu i bez rozmów. To droga niewygodna by opuścić swoją strefę komfortu i powiedzieć Bogu: “jestem tutaj nie dlatego, że masz coś dla mnie zrobić, jestem, bo chcę się z Tobą spotkać.” Celem Ekstremalnej Drogi Krzyżowej jest spotkanie z Bogiem.
Więcej o idei EDK na www.edk.org.pl/czym-jest-edk.

Salezjańska Ekstremalna Droga Krzyżowa jest z piątku na sobotę przed IV niedzielą wielkiego postu. To niedziela L’aetare (łac. radować się). Nazwa pochodzi od pierwszych słów antyfony mszy: Laetare, Ierusalem… (wesel się, Jeruzalem…). Ksiądz Bosko często mówił “bądź zawsze radosny”. Autentyczna radość ma swoje źródło w Bogu, dlatego salezjańska EDK to okazja by przyjrzeć się swojej relacji z Bogiem, zobaczyć co nam tę radość zabiera i jak jednoczyć swoje bolączki z Jego ramami “w których jest nasze zdrowie”.

Rozpoczynamy Mszą św. o godz. 18.00. Wyjście o godz. 19.00. Zgłoszenia na stronie www.edk.org.pl rejon Wrocław Salezjanie. Dla osób zapisanych są wydawane pakiety: rozważania, opis trasy, odblaski. Do organizacji tego wszystkiego potrzeba ludzi : )'''),

          StaffMemberCard(name: 'Aleksandra Pydo', title: "Kajaki", imagePath: "assets/photos/Ola-Pydo-600x600.jpg", description: '''Można powiedzieć, że temat rzeka. Tym bardziej, że co roku inna. Jednak pewne rzeczy się nie zmieniają:

woda wszędzie,
kajak lepszy niż siłownia,
sklep znany tylko z opowieści,
szanty każdego dnia,
bezcenna radość z każdej kromki chleba, kranu, a co dopiero z kropli ciepłej wody z niego lecącej!
Jeśli chciałbyś zabawić się z Nami w kolonistę z prawdziwego zdarzenia, to nie stój w miejscu, tylko idź z prądem. Z nami spłyń!'''),

          StaffMemberCard(name: 'Teresa Pelczar', title: "Rowery", imagePath: "assets/photos/Teresa-Pelczar-600x600.jpg", description: '''W czasie, gdy pogoda obdarowuje nas ciepłem, organizujemy nasze MOSTowe rowery. Jest to doskonała okazja do poznania MOSTowiaków, aktywności fizycznej, a także spędzenia miło czasu przy ognisku. Ogłoszenia o rowerach pojawiają się z wyprzedzeniem na stronie MOSTu i podczas Mszy Świętej, by każdy zainteresowany otrzymał potrzebne informacje i bez pośpiechu mógł się zapisać.'''),

          StaffMemberCard(name: 'Poniedziałek - Julia Biernacka', title: "Msze w tygodniu", imagePath: "assets/photos/Julia-Biernacka-600x600.jpg", description: '''“Kto śpiewa, ten dwa razy się modli.”
Warto wcielić w życie słowa św. Augustyna i dołączyć do MOSTowej scholi! Jeśli kochasz muzykę i chcesz, by Twój śpiew stał się modlitwą, czekamy na Ciebie każdego dnia (oprócz wtorków i sobót) o 18:30 w salce kaflowej, a w niedzielę o 18:00.'''),

          StaffMemberCard(name: 'Środa - Roman Switana', title: "Msze w tygodniu", imagePath: "assets/photos/Roman-Svitana-600x600.jpg", description: '''“Kto śpiewa, ten dwa razy się modli.”
Warto wcielić w życie słowa św. Augustyna i dołączyć do MOSTowej scholi! Jeśli kochasz muzykę i chcesz, by Twój śpiew stał się modlitwą, czekamy na Ciebie każdego dnia (oprócz wtorków i sobót) o 18:30 w salce kaflowej, a w niedzielę o 18:00.'''),

          StaffMemberCard(name: 'Czwartek - Tosia Rachwał', title: "Msze w tygodniu", imagePath: "assets/photos/Tosia-Rachwal-600x600.jpg", description: '''“Kto śpiewa, ten dwa razy się modli.”
Warto wcielić w życie słowa św. Augustyna i dołączyć do MOSTowej scholi! Jeśli kochasz muzykę i chcesz, by Twój śpiew stał się modlitwą, czekamy na Ciebie każdego dnia (oprócz wtorków i sobót) o 18:30 w salce kaflowej, a w niedzielę o 18:00.'''),

          StaffMemberCard(name: 'Piątek - Teresa Śmidoda', title: "Msze w tygodniu", imagePath: "assets/photos/Kobieta-awatar.jpg", description: '''“Kto śpiewa, ten dwa razy się modli.”
Warto wcielić w życie słowa św. Augustyna i dołączyć do MOSTowej scholi! Jeśli kochasz muzykę i chcesz, by Twój śpiew stał się modlitwą, czekamy na Ciebie każdego dnia (oprócz wtorków i sobót) o 18:30 w salce kaflowej, a w niedzielę o 18:00.'''),

          StaffMemberCard(name: 'Karolina Rakicka', title: "Wieczorki muzyczne", imagePath: "assets/photos/Karolina-Rakicka-600x600.jpg", description: '''Przez wielu najbardziej wyczekiwany czwartek w semestrze – to właśnie wtedy odbywa się charytatywny wieczorek muzyczny! Za każdym razem wcielamy się w różnorodne postacie, odzwierciedlając różne emocje i podróżując po fantastycznych miejscach, zgodnie z tematem spotkania. To doskonała okazja, by posłuchać naszych utalentowanych MOSTowiaków na stolarnianej scenie.

Jednak to nie tylko muzyka sprawia, że ten wieczór jest szczególny. To także szansa na wsparcie szczytnego celu, podczas gdy zbieramy fundusze przy okazji kiermaszu ciast. Chcesz wziąć udział w tym wydarzeniu? Może masz talent muzyczny i chciałbyś wystąpić na naszej scenie? Może twój zmysł kulinarny sprawi, że zechcesz podzielić się z nami swoim wypiekiem? Albo Twoja kreatywność pomoże w przygotowaniu pięknych dekoracji?

Jeśli na chociaż jedno z tych pytań odpowiedziałeś twierdząco, serdecznie zapraszam do kontaktu z naszą przęsłową lub podprzęsłowymi! Razem stwórzmy niezapomniany wieczór, który na długo pozostanie w naszej pamięci!'''),

          StaffMemberCard(name: 'Ula Rudnicka', title: "Wieczorki muzyczne", imagePath: "assets/photos/Ula-Rudnicka-600x600.jpg", description: '''Przez wielu najbardziej wyczekiwany czwartek w semestrze – to właśnie wtedy odbywa się charytatywny wieczorek muzyczny! Za każdym razem wcielamy się w różnorodne postacie, odzwierciedlając różne emocje i podróżując po fantastycznych miejscach, zgodnie z tematem spotkania. To doskonała okazja, by posłuchać naszych utalentowanych MOSTowiaków na stolarnianej scenie.

Jednak to nie tylko muzyka sprawia, że ten wieczór jest szczególny. To także szansa na wsparcie szczytnego celu, podczas gdy zbieramy fundusze przy okazji kiermaszu ciast. Chcesz wziąć udział w tym wydarzeniu? Może masz talent muzyczny i chciałbyś wystąpić na naszej scenie? Może twój zmysł kulinarny sprawi, że zechcesz podzielić się z nami swoim wypiekiem? Albo Twoja kreatywność pomoże w przygotowaniu pięknych dekoracji?

Jeśli na chociaż jedno z tych pytań odpowiedziałeś twierdząco, serdecznie zapraszam do kontaktu z naszą przęsłową lub podprzęsłowymi! Razem stwórzmy niezapomniany wieczór, który na długo pozostanie w naszej pamięci!'''),

          StaffMemberCard(name: 'Gabrysia Jędrszczyk', title: "Wieczorki muzyczne", imagePath: "assets/photos/Gabrysia-Jedrszczyk-600x600.jpg", description: '''Przez wielu najbardziej wyczekiwany czwartek w semestrze – to właśnie wtedy odbywa się charytatywny wieczorek muzyczny! Za każdym razem wcielamy się w różnorodne postacie, odzwierciedlając różne emocje i podróżując po fantastycznych miejscach, zgodnie z tematem spotkania. To doskonała okazja, by posłuchać naszych utalentowanych MOSTowiaków na stolarnianej scenie.

Jednak to nie tylko muzyka sprawia, że ten wieczór jest szczególny. To także szansa na wsparcie szczytnego celu, podczas gdy zbieramy fundusze przy okazji kiermaszu ciast. Chcesz wziąć udział w tym wydarzeniu? Może masz talent muzyczny i chciałbyś wystąpić na naszej scenie? Może twój zmysł kulinarny sprawi, że zechcesz podzielić się z nami swoim wypiekiem? Albo Twoja kreatywność pomoże w przygotowaniu pięknych dekoracji?

Jeśli na chociaż jedno z tych pytań odpowiedziałeś twierdząco, serdecznie zapraszam do kontaktu z naszą przęsłową lub podprzęsłowymi! Razem stwórzmy niezapomniany wieczór, który na długo pozostanie w naszej pamięci!'''),

          StaffMemberCard(name: 'Kostek Żuk', title: "Gitara z mostem", imagePath: "assets/photos/Kostek-Zuk-600x600.jpg", description: '''Zawsze chciałeś nauczyć się grać na gitarze, ale brakowało Ci motywacji lub kogoś, kto Cię poprowadzi? A może już grasz, ale chcesz się rozwijać i czerpać radość z muzykowania w fajnej atmosferze? Gitara z Mostem to miejsce właśnie dla Ciebie. Czeka na Ciebie nauka gry na gitarze, zarówno od podstaw, jak i na bardziej zaawansowanym poziomie. Repertuar jest dostosowany do Twoich możliwości i gustu, a także obejmuje zarówno proste akordy, jak i piękne aranżacje.

Nie musisz mieć doświadczenia ani profesjonalnego sprzętu – wystarczy chęć do nauki i dobra energia. Jeśli kiedykolwiek marzyłeś o tym, by wziąć gitarę do ręki i zagrać pierwsze akordy, to jest ten moment. Dołącz do nas i przekonaj się, jak wspaniale jest tworzyć muzykę razem. Masz pytania? Skontaktuje sie z przęsłową lub podprzęsłowym! Do zobaczenia!!'''),




          SizedBox(height: 20),
        ],
      ),
    );
  }
}
